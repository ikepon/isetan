namespace :db do
  namespace :seed do
    task 'create_users' => :environment do
      3.times do |i|
        FactoryGirl.create(
          :user,
          name: "user#{i + 1}",
          email: "user#{i + 1}@example.com",
          password: 'password',
          profile: "#{i + 1}たくさん本を読んで、いろんなことを知りたい、元気いっぱいの30代！",
          sign_in_count: i
        )
      end

      # 管理者作成
      FactoryGirl.create(
        :user,
        name: 'admin',
        email: 'admin@example.com',
        password: 'password',
        profile: '管理者です！',
        sign_in_count: 3,
        role: 1
      )
    end
  end
end
