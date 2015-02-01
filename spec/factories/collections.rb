FactoryGirl.define do
  factory :collection do
    status 1
    rented_at Time.zone.now
    returned_at 7.days.from_now

    trait :collection_whatever do
      user { create(:user) }
      book { create(:book) }
    end
  end
end
