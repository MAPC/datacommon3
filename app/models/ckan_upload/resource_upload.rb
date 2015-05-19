module CKANUpload
  class ResourceUpload
    include Capybara::DSL

    attr_accessor :layer, :fields, :extent

    def initialize(layer, extent)
      @layer  = layer
      @extent = extent
      @fields = {
        :'Port'          => 5432,
        :'Host'          => ENV.fetch('CKAN_RESOURCE_HOST'),      # i.e.: db.stage.mydomain.org
        :'User'          => ENV.fetch('CKAN_DATAPROXY_USERNAME'),
        :'Password'      => ENV.fetch('CKAN_DATAPROXY_PASSWORD'),
        :'Database name' => 'geographic',
        :'Table'         => "#{ @layer.schema }.#{ @layer.tablename }#{ @extent.table_suffix }",
        :'Name'          => "#{ @extent.title }",
        :'Description'   => "#{ @layer.descriptn } by #{ @extent.title }"
      }
      # METADATA
      @fields[:Name]  = "Metadata - " << @fields[:Name]
      @fields[:Table] = @fields[:Table].gsub('tabular','metadata')
    end

    def perform
      puts "INFO: Starting new resource #{@extent.title} (#{@layer.title})"
      start_form
      puts "(ResourceUpload) DEBUG: Filling in fields."
      fill_in_fields
      submit
    end

    def start_form
      visit new_resource_path
      puts "(ResourceUpload) DEBUG: Starting new resource form on #{new_resource_path}"
      begin
        click_button 'DataProxy'
        puts "(ResourceUpload) DEBUG: Clicked DataProxy"
      rescue
        find(:xpath, "//a[@id='dataproxy-assist']").click
        puts "(ResourceUpload) DEBUG: Clicked DataProxy (xpath method)"
      ensure
      end
    end

    def fill_in_fields
      select 'PostgreSQL', from: 'Database type'
      @fields.each do |field_name, value|
        begin
          fill_in field_name.to_s, with: value
          puts "(ResourceUpload) DEBUG: filled in #{field_name} with #{value}"
        rescue
          puts "(ResourceUpload) DEBUG: Could not fill in #{field_name} with #{value} on #{page.current_path}"
        end
      end
      puts "(ResourceUpload) DEBUG: Filled in all fields."
    end

    def submit
      begin
        click_button 'Add'
        puts "(ResourceUpload) DEBUG: Clicked 'Add'"
      rescue
        click_button 'Next: Additional Info'
        puts "(ResourceUpload) DEBUG: Clicked 'Next: Additional Info'"
      end
    end

    def new_resource_path
      "http://#{ ENV.fetch('CKAN_BASE_URL') }/dataset/new_resource/#{ @layer.title.parameterize }"
    end
  end
end