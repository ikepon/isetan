# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

Amazon::Ecs.options = {
  :associate_tag =>     Rails.application.secrets.associate_tag,
  :AWS_access_key_id => Rails.application.secrets.AWS_access_key_id,
  :AWS_secret_key =>   Rails.application.secrets.AWS_secret_key
}
