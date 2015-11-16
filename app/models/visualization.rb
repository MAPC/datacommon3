class Visualization < ActiveRecord::Base
  self.table_name = 'weave_visualization'
  self.primary_key = :id

  PERMISSIONS = ['public', 'private']

  # before_save :update_time
  before_save :strip_trailing_whitespace
  before_validation :stringify_permissions

  belongs_to :original, class_name: "Visualization", foreign_key: :original_id

  has_and_belongs_to_many :data_sources,
    join_table: :weave_visualization_datasources,
    association_foreign_key: :datasource_id

  has_and_belongs_to_many :issue_areas,
    join_table: :weave_visualization_topics,
    association_foreign_key: :topic_id

  has_attached_file :image, styles: { gallery:  ['205x137>', :png],
                                      featured: ['455x305>', :png] }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  belongs_to :institution
  belongs_to :user, foreign_key: :owner_id
  alias_attribute :owner, :user

  lazy_load :sessionstate

  include InstitutionScope
  include DataResourceFilters
  include RandomScope

  validates :title,      presence: true, length: { minimum: 3,  maximum: 140 }
  validates :abstract,   presence: true, length: { minimum: 14, maximum: 560 }
  validates :permission, presence: true, inclusion: { in: PERMISSIONS,
             message:   "Permission must be 'public' or 'private', but you assigned \"%{value}\"." }
  validates :sessionstate, presence: true, length: { minimum: 100 }
  validates :year,       allow_blank: true, length: { minimum: 4,  maximum: 50  }

  # validates :institution_id, allow_blank: true,
  #   inclusion: { in: (Institution.pluck(:id)),
  #   message: "must be one of #{(Institution.pluck(:id))}, but you assigned \"%{value}\"."
  # }

  validates :user, presence: true

  paginates_per 12

  def self.default_scope
    order('id DESC').where(permission: 'public')
  end

  def self.featured
    # Default to most recent if there is no featured visualization
    self.where('featured IS NOT NULL').order(:featured) || self.recent(1)
  end

  def self.showing # for use when showing details
    self.includes(:issue_areas)
  end

  def self.recent(count=4)
    self.order('updated_at DESC').limit(count)
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

  def years
    year.to_s.split(',')
  end

  def abstract
    read_attribute(:abstract).presence || "No abstract."
  end

  def to_s
    title
  end


  alias_method :owner, :user


  rails_admin do
    list do
      field :title
      field :abstract do
        formatted_value { bindings[:object].abstract[0..50] }
      end
      field :owner do
        formatted_value {
          Institution.find_by(id: bindings[:object].owner_id)
        }
      end
      field :institution_id do
        formatted_value {
          Institution.find_by(id: bindings[:object].institution_id).try(:short_name)
        }
      end
    end

    edit do
      field :title
      field :abstract
      field :year
      field :data_sources
      field :issue_areas
      field :featured
      field :institution
      field :permission
      field :image, :paperclip
      field :sessionstate
    end
  end


  private

    def self.issue_area_for(issue_area_or_slug)
      case issue_area_or_slug
      when String then IssueArea.find_by(slug: issue_area_or_slug)
      else
        issue_area_or_slug
      end
    end

    # def update_time
    #   self.last_modified = Time.now
    # end

    def strip_trailing_whitespace
      %w( title abstract year ).each {|attribute|
        self.send(attribute).to_s.strip!
      }
    end

    def stringify_permissions
      self.permission = self.permission.to_s
    end

end
