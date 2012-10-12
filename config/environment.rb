# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
SupportKoombea::Application.initialize!

#ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :user_name => "app7104717@heroku.com",
  :password => "4torw8sb",
  :domain => "heroku.com",
  :address => "smtp.sendgrid.net",
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}