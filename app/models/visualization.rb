class Visualization < ActiveRecord::Base  
  self.table_name = 'weave_visualization'
  PERMISSIONS = ['public', 'private']

  before_save :update_time
  
  has_and_belongs_to_many :data_sources,
    join_table: :weave_visualization_datasources,
    association_foreign_key: :datasource_id

  has_and_belongs_to_many :issue_areas,
    join_table: :weave_visualization_topics,
    association_foreign_key: :topic_id

  # has_attached_file :image,
  #                    styles: { gallery: ['205x137>', :png], featured: ['455x305>', :png] },
  #                    url: ":class/images/:style/:id_:style.:extension"

  belongs_to :institution
  belongs_to :user, foreign_key: :owner_id

  include InstitutionScope
  include DataResourceFilters

  def self.default_scope
    order('id DESC').where(permission: 'public')
  end

  validates :title,      presence: true, length: { minimum: 3,  maximum: 140 }
  validates :year,       presence: true, length: { minimum: 4,  maximum: 20  }
  # validates :abstract,   presence: true, length: { minimum: 70, maximum: 560 }
  validates :permission, presence: true, inclusion: { in: PERMISSIONS,
             message: "Permission must be 'public' or 'private', but you assigned \"%{value}\"." }
  # validates :data_source_ids, allow_blank: true, inclusion: { in: DataSource.pluck(:id) }
  # validates :issue_area_ids,  allow_blank: true, inclusion: { in: IssueArea.pluck(:id) }
  validates :institution_id,  allow_blank: true, inclusion: { in: Institution.pluck(:id) }

  validates :sessionstate, presence: true, length: { minimum: 100 }

  lazy_load :sessionstate

  paginates_per 8
  # max_paginates_per 16

  def self.featured
    self.where('featured IS NOT NULL').order(:featured)
  end

  
  def self.random
    self.offset(rand(self.count(:all))).first
  end


  def self.showing # for use when showing details
    self.includes(:issue_areas)
  end


  def self.recent(count=4)
    self.order('last_modified DESC').limit(count)
  end


  def self.public
    where(permission: 'public')
  end


  def self.private
    where(permission: 'private')
  end


  def private?
    permission == "private"
  end


  def public?
    !private?
  end


  def owner_display_name
    owner.name
  end

  def abstract
    read_attribute(:abstract).presence || "No abstract."
  end

  def base_image_path
    "/visualizations/images/#{id}"
  end


  def full_image_path
    "/visualizations/images/#{id}.png"
  end  


  def gallery_image_path
    "#{base_image_path}_gallery.png"
  end


  def preview_image_path
    "#{base_image_path}_featured.png"
  end


  def to_s
    title
  end

  alias_method :owner, :user


  private

    def self.issue_area_for(issue_area_or_slug)
      case issue_area_or_slug
      when String then IssueArea.find_by(slug: issue_area_or_slug)
      else
        issue_area_or_slug
      end
    end

    def update_time
      self.last_modified = Time.now
    end

end
