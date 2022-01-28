# Load the Rails application.
require_relative 'application'

config.action_mailer.default_url_options = { :host => 'berlintabletennismap.com', :protocol => 'http' }
      config.action_mailer.perform_deliveries = true
      config.action_mailer.delivery_method = :smtp

# Initialize the Rails application.
Rails.application.initialize!
