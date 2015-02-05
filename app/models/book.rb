# encoding: utf-8

class Book < ActiveRecord::Base
  has_many :collections

  accepts_nested_attributes_for :collections

  validates :title, presence: true
  validates :asin,  presence: true, uniqueness: true, length: { in: 10..13 }

  mount_uploader :book_cover, BookCoverUploader
end
