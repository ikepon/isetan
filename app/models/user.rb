class User < ActiveRecord::Base

  with_options presence: true do |required|
    required.validates :name
    required.validates :email
    required.validates :password_digest
  end

  mount_uploader :image, ImageUploader
end
