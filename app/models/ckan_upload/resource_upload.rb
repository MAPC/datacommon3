module CKANUpload
  class ResourceUpload
    include Capybara::DSL

    attr_accessor :layer, :fields, :extent

    def initialize(layer, extent)
      @layer  = layer
      @extent = extent
      @fields = {
        :'Port'          => 5432,
        :'Host'          => 'db.dev.mapc.org',
        :'User'          => ENV.fetch('CKAN_DATAPROXY_USERNAME'),
        :'Password'      => ENV.fetch('CKAN_DATAPROXY_PASSWORD'),
        :'Database name' => 'geographic',
        :'Table'         => "#{ @layer.schema }.#{ @layer.tablename }#{ @extent.table_suffix }",
        :'Name'          => "#{ @extent.title }",
        :'Description'   => "#{ @layer.descriptn } by #{ @extent.title }"
      }
    end

    def perform
      puts "Starting on a resource..."
      puts page.current_path
      start_form ; fill_in_fields ; submit
    end

    def start_form
      puts "Starting resource form"
      visit "http://ckan.dev.mapc.org/dataset/new_resource/#{ @layer.title.parameterize }"
      puts "visited #{page.current_path}"
      begin
        click_button 'DataProxy'
        puts "clicked DataProxy"
      rescue
        find(:xpath, "//a[@id='dataproxy-assist']").click
        puts "found XPATH for DataProxy"
      ensure
      end
    end

    def fill_in_fields
      puts "filling in fields on #{page.current_path}"
      select 'PostgreSQL', from: 'Database type'
      @fields.each do |field_name, value|
        begin
          fill_in field_name.to_s, with: value
          puts "filled in #{field_name} with #{value}"
        rescue
          puts "Could not fill in #{field_name} with #{value}"
        end
      end
    end

    def submit
      puts "Submitting resource..."
      begin
        click_button 'Next: Additional Info'
        puts "clicked 'Next: Additional Info'"
      rescue
        click_button 'Add'
        puts "clicked 'Add'"
      end
    end
  end
end