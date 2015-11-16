module ErrorHelper
  # TODO Should do what Thoughbot does and always have Airbrake
  # present, just configure it not to fire on production.
  def trigger_airbrake(error)
    if Rails.env == 'production'
      ENV["airbrake.error_id"] = notify_airbrake(error)
    end
  end
end