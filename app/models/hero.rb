class Hero < ActiveRecord::Base
  self.establish_connection :datacommon
  self.table_name = 'mbdc_hero'

  # belongs_to :institution

  def self.random
    self.offset(rand(self.count(:all))).first
  end


  def image_src
    "http://metrobostondatacommon.org/site_media/#{image}"
  end


  def to_html
    self._content_rendered
  end


  def to_s
    self.content
  end

end
