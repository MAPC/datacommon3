class Dataset

  DEFAULT_PER_PAGE = 10

  def self.all
    CKAN::Package.find()
  end

  # .find_by id: params[:id]
  def self.find_by(hash)
    packages = CKAN::Package.find(hash)
    # Returns one package if searching by ID
    hash.keys.include?(:id) ? packages.first : packages
  end

  def self.page(page_number=nil, options={})
    # TODO: Use splat so .page(1) and .page(per_page: 5)
    #       are both valid method calls.
    page_number   = (page_number || 1).to_i
    per_page = options.fetch(:per_page) { DEFAULT_PER_PAGE }

    records = CKAN::Package.find( 
      rows:   per_page,
      start:  page_number * per_page
    )

    OpenStruct.new(
      records:      records,
      current_page: page_number,
      total_pages:  total_pages,
      per_page:     per_page
    )
  end

  def self.total_pages(per_page=DEFAULT_PER_PAGE)
    @@total_pages ||= (self.all.count / per_page)
  end
  
end


class CKAN::Package
  def to_partial_path
    "datasets/dataset"
  end
end
