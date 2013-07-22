# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Ellajune::Application.initialize!

#Sendgrid configuration
ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => ENV['app16378421@heroku.com'],
  :password       => ENV['zdhfew4d'],
  :domain         => 'ellajune.coop',
  :enable_starttls_auto => true
}