class Dataset

  dstruct = Struct.new("Dataset", :records, :per_page, :current_page, :total_pages) do
    %w( count size length each map ).each do |method_name|
      define_method method_name do
        records.send(method_name)
      end
    end
    
    def method_missing(method_name, *args, &block)
      records.send(method_name, args)
    end

    def limit_value
      per_page
    end
  end

  DEFAULT_PER_PAGE = 10

  def self.per_page
    DEFAULT_PER_PAGE
  end

  def self.all
    begin
      CKAN::Package.find()
    rescue
      []
    end
  end

  def self.count
    self.all.count
  end

  def self.find_by(options)
    begin
      records = CKAN::Package.find(options)
    rescue
      records = []
    end

    current_page = options.fetch(:page) { 1 }
    per_page     = options.fetch(:per_page) { DEFAULT_PER_PAGE }
    total_pages  = records.length / per_page
    Struct::Dataset.new(records, per_page, current_page, total_pages)
  end

  def self.page(current_page=nil, options={})
    # TODO: Use splat so .page(1) and .page(per_page: 5)
    #       are both valid method calls.
    current_page = (current_page || 1).to_i
    per_page     = options.fetch(:per_page) { DEFAULT_PER_PAGE }
    
    begin
      records = CKAN::Package.find(rows: per_page, start: current_page * per_page)
    rescue
      records = []
    end
    Struct::Dataset.new(records, per_page, current_page, self.total_pages) # -> self.total_pages?
  end

  def self.total_pages(per_page=DEFAULT_PER_PAGE)
    @@total_pages ||= (self.all.count / per_page) - 1
  end
  
end
