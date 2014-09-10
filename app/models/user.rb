class User < ActiveRecord::Base

  with_options presence: true do |required|
    required.validates :name, length: { maximum: 50 }
    required.validates :email, uniqueness: true
    required.validates :password_digest
  end

  mount_uploader :image, ImageUploader
end
