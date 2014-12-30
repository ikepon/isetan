class Book < ActiveRecord::Base
  has_many :collections
  has_many :reviews

  accepts_nested_attributes_for :collections

  validates :isbn, uniqueness: true
  validates :isbn, numericality: { only_integer: true }
  validates :isbn, length: { in: 10..13 }
end
