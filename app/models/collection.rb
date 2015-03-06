class Collection < ActiveRecord::Base
  belongs_to :book
  belongs_to :user

  has_many :reviews

  # ステータス: reservable: 予約可, rented: 貸出中, expired: 返却遅延
  enum status: {na: 0, '貸出可': 1, '貸出中': 2, '返却遅延中': 3}

  scope :rental_books, -> { where(user_id: User.company_account)}
end
