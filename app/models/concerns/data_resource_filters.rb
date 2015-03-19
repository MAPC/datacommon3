module DataResourceFilters
  extend ActiveSupport::Concern

  def self.included(klass)
    klass.instance_eval do
      scope :topic,       -> t { joins(:issue_areas).where( "mbdc_topic.slug = ?",    t) }
      scope :data_source, -> d { joins(:data_sources).where("mbdc_datasource.id = ?", d) }

      alias_method :topics, :issue_areas
    end
  end
  
end