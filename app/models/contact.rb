class Contact < ActiveRecord::Base
  validates :category, presence: true
  validates :name,     presence: true, length: { maximum: 50 }
  validates :email,    presence: true, length: { maximum: 255 }
  validates :content,  presence: true
end
