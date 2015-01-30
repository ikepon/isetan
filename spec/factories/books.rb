FactoryGirl.define do
  factory :book do
    title 'ステキな本'
    sequence(:asin) { |n| "123456789#{n}" }
    wanted 1
    read 3
    rental 5
    book_cover { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'no_image_book.gif')) }
  end
end
