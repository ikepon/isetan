class Review < ActiveRecord::Base
  has_one :book, through: :collection
  has_one :user, through: :collection

  belongs_to :collection

  validates :title,  presence: true, length: { maximum: 50 }
  validates :content, presence: true
end
