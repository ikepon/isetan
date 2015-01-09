class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  validates :title,  presence: true, length: { maximum: 50 }
  validates :review, presence: true
end
