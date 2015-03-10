class Hero < ActiveRecord::Base
  self.table_name = 'mbdc_hero'

  before_save :create_or_use_nav_titles
  before_save :markup_type_or_default
  before_save :render_content

  belongs_to :institution

  validates :title,    presence: true
  validates :subtitle, presence: true
  validates :active,   inclusion: { in: [true, false] }
  validates :content,  presence: true

  has_attached_file :image, styles: { preview: ['500x375>', :png] }
  validates :image_file_name, presence: true
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  
  def self.active
    where(active: true).order(:order)
  end

  include RandomScope
  include InstitutionScope

  def image_src
    "http://metrobostondatacommon.org/site_media/#{image}"
  end

  def to_html
    _content_rendered.presence || self.content
  end

  def to_s
    title
  end

  rails_admin do
    list do
      scopes [nil, :active]
      field :title
      field :order
      field :active
      field :institution_id do
        formatted_value {
          Institution.find_by(id: bindings[:object].institution_id).try(:short_name)
        }
      end
    end
    edit do
      field :title
      field :subtitle
      field :navtitle do
        label "Link title"
      end
      field :navsubtitle do
        label "Link subtitle"
      end
      field :content do
        label "Raw content"
      end
      field :content_markup_type do
        label "Content markup type"
        help "One of 'html' (default), 'markdown', or 'raw'."
      end
      field :image, :paperclip
      field :order do
        label "Sort order"
      end
      field :active
      field :institution do
        visible false
        # Default to the user's institution if staff,
        # but allow any if the current user is an admin.
        default_value do
          bindings[:view]._current_user.institution_id
        end
      end
    end
  end

  private

    def create_or_use_nav_titles
      self.navtitle    ||= self.title
      self.navsubtitle ||= self.subtitle
    end

    def markup_type_or_default
      self.content_markup_type ||= 'html'
    end

    def render_content
      self._content_rendered = self.content
    end

end
