# Be sure to restart your server when you modify this file.

# Configure sensitive parameters which will be filtered from the log file.
params = [:password, :password_confirmation, :sessionstate]
Rails.application.config.filter_parameters += params
