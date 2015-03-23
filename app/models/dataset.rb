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
    page_number   = (page_number || 1).to_i
    paginates_per = options.fetch(:paginates_per) { 10 }

    puts "page_number: #{page_number}"
    puts "paginates_per: #{paginates_per}"

    records = CKAN::Package.find( 
      rows:   paginates_per,
      start:  page_number * paginates_per
    )
    OpenStruct.new(records: records,
      current_page: page_number,
      total_pages: 100,
      per_page: 10,
      )
  end
  
end


class CKAN::Package
  def to_partial_path
    "datasets/dataset"
  end
end
