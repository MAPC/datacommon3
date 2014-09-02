class Page < ActiveRecord::Base

  belongs_to :institution
  belongs_to :page_topi

  def self.default_scope
    order(:sort_order)
  end



  def body
    # Place it in /public so we can have the member
    # FTP into the folder and change it whenever.
    file_path = "#{Rails.root}/public/pages/#{institution_id}/#{topic_id}/#{slug}.html.haml"
    
    # Fall back on the MetroBoston page if there's no Central Mass page.
    unless File.exists? file_path
      file_path = "#{Rails.root}/public/pages/1/#{topic_id}/#{slug}.html.haml"
    end

    File.open(File.expand_path file_path).read
  end

  alias_method :content, :body


  def to_param
    slug.downcase.parameterize
  end


  def self.institution_topic(inst_or_id, slug)
    # institution = institution_for(inst_or_id)
    # topic       = topic_for(topic_or_slug)
    # self.find_all_by(institution: institution, topic: topic)
    self.where(institution_id: inst_or_id.id).where(topic_id: slug)
  end

  def title
    slug.titleize
  end

end
