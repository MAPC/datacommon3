class Search < ActiveRecord::Base
  extend Textacular

  attr_accessor :query

  paginates_per 8

  belongs_to :searchable, polymorphic: true

  def results
    if @query.present?
      self.class.search(@query).preload(:searchable).to_a.map!(&:searchable).uniq
    else
      Search.none
    end
  end
end
