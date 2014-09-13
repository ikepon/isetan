class User < ActiveRecord::Base
  before_save { self.email = email.downcase }

  with_options presence: true do |required|
    required.validates :name, length: { maximum: 50 }
    required.validates :email, uniqueness: { case_sensitive: false }
    required.validates :password, length: { minimum: 6 }
  end

  mount_uploader :image, ImageUploader

  has_secure_password
end
