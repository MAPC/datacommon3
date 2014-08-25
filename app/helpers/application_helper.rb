module ApplicationHelper

  def topics
    @topics = IssueArea.all
  end


  # def about_pages
  #   Page.institution_topic(@institution, 'about')
  # end

  # def data_day_pages
  #   Page.institution_topic(@institution, 'community')
  # end

  # def resources_pages
  #   Page.institution_topic(@institution, 'resources')
  # end

end
