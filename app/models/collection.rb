class Collection < ActiveRecord::Base
  belongs_to :book
  belongs_to :user

  has_many :reviews

  # ステータス: reservable: 予約可, rented: 貸出中, expired: 返却遅延
  enum status: {reservable: 1, rented: 2, expired: 3}
end
