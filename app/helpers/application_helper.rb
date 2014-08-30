module ApplicationHelper

  def topics
    @topics = IssueArea.all
  end


  def about_pages
    Page.institution_topic(@institution, 'about')
  end


  def community_pages
    Page.institution_topic(@institution, 'community')
  end


  def resources_pages
    Page.institution_topic(@institution, 'resources')
  end


  def indefinite_articlerize(word)
    %w(a e i o u).include?(word[0].downcase) ? "an #{word}" : "a #{word}"
  end

  
  def avatar_url(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      default_url = "#{root_url}images/guest.png"
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=75"
    end
  end



  alias_method :indef_article, :indefinite_articlerize

end
