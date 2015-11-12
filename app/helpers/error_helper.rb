module ErrorHelper
  def trigger_airbrake(error)
    if Rails.env == 'production'
      ENV["airbrake.error_id"] = notify_airbrake(error)
    end
  end
end