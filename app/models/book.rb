class Book < ActiveRecord::Base
  has_many :collections
  has_many :reviews
end
