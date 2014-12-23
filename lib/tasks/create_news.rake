namespace :db do
  namespace :seed do
    task 'create_news' => :environment do
      7.times do |i|
        FactoryGirl.create(
          :news,
          title: "News title #{i + 1}",
          content: "News content#{i + 1}: Your advertisement for an experienced Marketing Manager, posted on the CareerCross website, caught my attention. After reviewing my enclosed resume, I hope you will agree that my qualifications match your needs, and consider me for the position.",
          created_at: DateTime.new(2014, 10, 1) + i
        )
      end
    end
  end
end
