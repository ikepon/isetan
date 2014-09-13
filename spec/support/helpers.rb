shared_context 'ユーザーとしてログインしている' do |user|
  let!(:current_user) { create(user) }

  background do
    visit login_path

    fill_in 'email', with: current_user.email
    fill_in 'password_digest', with: current_user.password_digest

    click_on 'ログインする'
  end
end
