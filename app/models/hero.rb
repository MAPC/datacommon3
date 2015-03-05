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
  
  def self.default_scope
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
