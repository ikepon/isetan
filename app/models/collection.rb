class Collection < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  belongs_to :borrower, class_name: 'User'
  has_many :reviews

  # ステータス: reservable: 予約可, rented: 貸出中, expired: 返却遅延
  enum status: {na: 0, reservable: 1, rented: 2, expired: 3}

  scope :rental_books, -> { where(user_id: User.company_account)}
end
