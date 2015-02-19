class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_create :create_remember_token

  has_many :collections
  has_many :books, through: :collections
  has_many :reviews, through: :collections

  with_options presence: true do |required|
    required.validates :name, length: { maximum: 50 }
    required.validates :email, uniqueness: { case_sensitive: false }
    required.validates :password, length: { minimum: 6 },
    unless: Proc.new { |a| a.password.blank? }
  end

  mount_uploader :image, ImageUploader

  has_secure_password

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
