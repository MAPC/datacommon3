module ApplicationHelper

  def topics
    @topics = IssueArea.all
  end
end
