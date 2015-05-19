class Logo < ActiveRecord::Base

  has_and_belongs_to_many :institutions
  has_attached_file :image, styles: { large: ['245x80>', :png] }

  default_scope { order(:sort_order) }

  validates :alt_text, presence: true, length: { minimum: 4 }
  validates :image_file_name, presence: true
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  rails_admin do
    list do
      field :image do
        formatted_value do
          bindings[:view].tag(:img, { :src => bindings[:object].image_url }) << value
        end
      end
      field :alt_text do
        label "Alt"
      end
      field :institutions
      field :sort_order
    end
    edit do
      field :alt_text do
        label "Alt"
      end
      field :image, :paperclip
      field :institutions
      field :sort_order
    end
  end
end
