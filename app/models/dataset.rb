class Dataset

  DEFAULT_PER_PAGE = 10

  Dataset = Struct.new(:records, :current_page, :total_pages, :per_page) do
    def method_missing(method_name, *args, &block)
      records.send(method_name, args, block)
    end
    def limit_value ; end # Pagination claimed records did not have limit_value
  end

  def self.all
    CKAN::Package.find()
  end

  def self.find_by(hash)
    packages = CKAN::Package.find(hash)
    hash.keys.include?(:id) ? packages.first : packages
  end

  def self.page(current_page=nil, options={})
    # TODO: Use splat so .page(1) and .page(per_page: 5)
    #       are both valid method calls.
    current_page = (current_page || 1).to_i
    per_page     = options.fetch(:per_page) { DEFAULT_PER_PAGE }
    
    records = CKAN::Package.find(rows: per_page, start: current_page * per_page)
    Dataset.new(records, current_page, total_pages, per_page)
  end

  def self.total_pages(per_page=DEFAULT_PER_PAGE)
    @@total_pages ||= (self.all.count / per_page)
  end
  
end
