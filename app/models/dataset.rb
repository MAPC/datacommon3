class Dataset

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
    # TODO: Use splat so .page(1) and .page(paginates_per: 5)
    #       are both valid method calls.
    page_number ||= 1
    paginates_per = options.fetch(:paginates_per) { 10 }

    CKAN::Package.find( 
      rows:   paginates_per,
      start:  page_number * paginates_per
    )
  end

  
end
