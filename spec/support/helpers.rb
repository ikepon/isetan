shared_context 'ユーザーとしてログインしている' do
  let!(:current_user) { create(:user) }

  background do
    visit login_path

    fill_in 'session[email]', with: current_user.email
    fill_in 'session[password]', with: current_user.password

    within '.login' do
      click_on 'Login'
    end
  end
end

