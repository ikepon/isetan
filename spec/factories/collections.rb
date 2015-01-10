FactoryGirl.define do
  factory :collection do
    status 1
    rented_at Time.zone.now
    returned_at 7.days.from_now
    user_id 1
    book_id nil
  end
end
