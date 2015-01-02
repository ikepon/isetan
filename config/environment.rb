# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

Amazon::Ecs.options = {
  :associate_tag =>     '987654321',
  :AWS_access_key_id => 'amazonaccesskey',
  :AWS_secret_key =>   'amazonsecretkey'
}
