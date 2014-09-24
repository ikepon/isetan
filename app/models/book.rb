class Book < ActiveRecord::Base
  has_many :collections
end
