class IssueArea < ActiveRecord::Base
  self.table_name = 'mbdc_topic'

  before_save :use_or_create_slug

  validates :title, presence: true

  has_and_belongs_to_many :visualizations,
    join_table:  :weave_visualization_topics,
    foreign_key: :topic_id

  has_and_belongs_to_many :dynamic_visualizations,
    join_table:  :snapshots_visualization_topics,
    foreign_key: :topic_id,
    association_foreign_key: :visualization_id

  default_scope { where("#{self.table_name}.id < ?", 13).order('"order" ASC') }

  def sort_order
    self.send(:order)
  end

  def to_s
    title
  end

  def to_param
    slug
  end

  private

    def use_or_create_slug
      self.slug = title.parameterize unless self.slug.presence
    end
  
end
