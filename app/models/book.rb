class Book < ActiveRecord::Base
  has_many :collections
  has_many :reviews

  accepts_nested_attributes_for :collections

  validates :title, presence: true
  validates :isbn,  presence: true, uniqueness: true, length: { in: 10..13 }
end
