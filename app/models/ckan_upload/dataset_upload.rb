module CKANUpload
  class DatasetUpload
    include Capybara::DSL

    attr_accessor :layer, :fields

    def initialize(layer)
      @layer  = layer
      @fields = {
        :Title             => @layer.title,          
        :URL               => @layer.title.parameterize, 
        :Description       => @layer.descriptn,      
        :s2id_autogen1     => @layer.topic.downcase << ',',  # Tags
        :Source            => @layer.creator,        
        :Maintainer        => @layer.publisher,      
        :'Maintainer Email'=> 'sbrunton@mapc.org',
        :extras__0__key    => 'Coverage', 
        :extras__0__value  => @layer.coverage,       
        :extras__1__key    => 'Universe',           
        :extras__1__value  => @layer.universe,       
        :extras__2__key    => 'Dates Available',    
        :extras__2__value  => @layer.datesavail
      }
    end

    def perform
      start_form ; fill_in_fields ; submit
      upload_resources
    end

    def exist?
      Dataset.all.map(&:id).include? @layer.title.parameterize
    end
    alias_method :exists?, :exist?

    def start_form
      visit "#{CKANUpload::DEFAULT_BASE_URL}/dataset/new"
      puts "visited /dataset/new"
    end

    def fill_in_fields
      @fields.each do |field_name, value|
        begin
          fill_in field_name.to_s, with: value
          puts "filled in #{field_name} with #{value}"
        rescue
          puts "Could not fill in #{field_name} with #{value}"
        end
      end
    end

    def upload_resources
      self.layer.spatial_extents.each do |extent|
        CKANUpload::ResourceUpload.new(layer, extent).perform
      end
    end

    def submit
      click_button 'Next: Add Data'
      puts "Submitted dataset."
    end
  end
end