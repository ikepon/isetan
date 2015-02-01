FactoryGirl.define do
  factory :book do
    sequence(:title) { |n| "ステキな本#{n}" }
    sequence(:asin) { |n| "123456789#{n}" }
    wanted 1
    read 3
    rental 5
    book_cover { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'no_image_book.gif')) }
  end
end
