class Page < ActiveHash::Base
  include ActiveHash::Associations

  belongs_to :institution
  belongs_to :page_topic


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
    self.find_all_by_institution_id(inst_or_id.id).keep_if {|pg| pg.topic_id == slug }
  end

  def title
    slug.titleize
  end


  self.data = [
    {
      id:              1,
      institution_id:  1,
      sort_order:      1,
      topic_id:       "about",
      slug:           "what-is-the-data-common"
    },
    {
      id:              2,
      institution_id:  1,
      sort_order:      2,
      topic_id:       "about",
      slug:           "faq"
    },
    {
      id:              3,
      institution_id:  1,
      sort_order:      3,
      topic_id:       "about",
      slug:           "tools"
    },
    {
      id:              4,
      institution_id:  1,
      sort_order:      4,
      topic_id:       "about",
      slug:           "partners"
    },
    {
      id:              5,
      institution_id:  1,
      sort_order:      5,
      topic_id:       "about",
      slug:           "contact"
    },
    {
      id:              6,
      institution_id:  1,
      sort_order:      6,
      topic_id:       'resources',
      slug:           "training-guides-and-tutorials"
    },
    {
      id:              7,
      institution_id:  1,
      sort_order:      7,
      topic_id:       'resources',
      slug:           "data-resources"
    },
    {
      id:              8,
      institution_id:  1,
      sort_order:      8,
      topic_id:       'resources',
      slug:           "user-profiles"
    },
    {
      id:              9,
      institution_id:  1,
      sort_order:      9,
      topic_id:       'community',
      slug:           "data-day-2009"
    },
    {
      id:              10,
      institution_id:  1,
      sort_order:      10,
      topic_id:       'community',
      slug:           "data-day-2012"
    },
    {
      id:              11,
      institution_id:  1,
      sort_order:      11,
      topic_id:       'community',
      slug:           "data-day-2013"
    },
    {
      id:              12,
      institution_id:  2,
      sort_order:      1,
      topic_id:       "about",
      slug:           "what-is-the-data-common"
    },
    {
      id:              13,
      institution_id:  2,
      sort_order:      2,
      topic_id:       "about",
      slug:           "faq"
    },
    {
      id:              14,
      institution_id:  2,
      sort_order:      3,
      topic_id:       "about",
      slug:           "tools"
    },
    {
      id:              15,
      institution_id:  2,
      sort_order:      4,
      topic_id:       "about",
      slug:           "partners"
    },
    {
      id:              16,
      institution_id:  2,
      sort_order:      5,
      topic_id:       "about",
      slug:           "contact"
    },
    {
      id:              17,
      institution_id:  2,
      sort_order:      6,
      topic_id:       'resources',
      slug:           "training-guides-and-tutorials"
    },
    {
      id:              18,
      institution_id:  2,
      sort_order:      7,
      topic_id:       'resources',
      slug:           "data-resources"
    },
    {
      id:              19,
      institution_id:  2,
      sort_order:      8,
      topic_id:       'resources',
      slug:           "user-profiles"
    },
    {
      id:              20,
      institution_id:  2,
      sort_order:      9,
      topic_id:       'community',
      slug:           "data-day-2009"
    },
    {
      id:              21,
      institution_id:  2,
      sort_order:      10,
      topic_id:       'community',
      slug:           "data-day-2012"
    },
    {
      id:              22,
      institution_id:  2,
      sort_order:      11,
      topic_id:       'community',
      slug:           "data-day-2013"
    }
  ]

end
