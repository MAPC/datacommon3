module ApplicationHelper

  def institutions_exist
    Institution.count > 0
  end

  def topics
    IssueArea.all
  end

  def name_slug_options(objects)
    options_for_select(objects.map {|g| [g.name, g.slug]})
  end

  def about_pages
    Page.institution_topic(@institution, 'about')
  end

  def topic_options
    options  = IssueArea.all.map {|i| [i.title, i.slug]}
    options.unshift ['All Topics', nil]
  end

  def data_source_options
    options  = DataSource.all.map {|i| [i.title, i.id]}
    options.unshift ['All Data Sources', nil]
  end

  def community_pages
    Page.institution_topic(@institution, 'community').reverse
  end


  def resources_pages
    Page.institution_topic(@institution, 'resources')
  end


  def indefinite_articlerize(word)
    %w(a e i o u).include?(word[0].downcase) ? "an #{word}" : "a #{word}"
  end

  def region_name_or(default='')
    @institution.try(:short_name) || default
  end

  
  def avatar_url(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      email = profile_or_user_email_for(user).downcase
      default_url = "#{root_url}images/guest.png"
      gravatar_id = Digest::MD5.hexdigest(email)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=75"
    end
  end

  def layer_count
    Dataset.count
  end

  def visualization_count
    Visualization.count
  end

  private

  def profile_or_user_email_for(user)
    if user.profile && user.profile.email
      user.profile.email
    else
      user.email
    end
  end



  alias_method :indef_article, :indefinite_articlerize

end
