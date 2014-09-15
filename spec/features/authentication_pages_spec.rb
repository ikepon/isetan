require 'spec_helper'

feature 'ログイン、ログアウト' do
  context 'ログインする' do
    let!(:user) { create(:user) }

    before do
      visit login_path
    end

    scenario '正しい情報を入れるとログインできる' do
      fill_in 'session[email]', with: 'user1@example.com'
      fill_in 'session[password]', with: 'user_password'

      within '.login' do
        click_on 'Login'
      end

      expect(page).to have_css('.user-name', text: 'user_name1')
      expect(page).to have_link('Profile', href: user_path(user))
      expect(page).to have_link('Logout', href: logout_path)
      expect(page).not_to have_link('Login', href: login_path)

    end

    scenario '間違ったemailを入れるとログインできない' do
      fill_in 'session[email]', with: 'other@example.com'
      fill_in 'session[password]', with: 'user_password'

      within '.login' do
        click_on 'Login'
      end

      expect(page).to have_css('.alert', text: 'メールアドレス、パスワードの組み合わせに誤りがあります。')
    end

    scenario '間違ったpasswordを入れるとログインできない' do
      fill_in 'session[email]', with: 'user1@example.com'
      fill_in 'session[password]', with: 'other_password'

      within '.login' do
        click_on 'Login'
      end

      expect(page).to have_css('.alert', text: 'メールアドレス、パスワードの組み合わせに誤りがあります。')
    end

    context 'ログアウトする' do
      include_context 'ユーザーとしてログインしている'

      scenario 'ログインした状態で、ログアウトする' do
        find('.dropdown-menu a', text: 'Logout').click

        expect(page).to have_css('h2', text: '蔵書管理 isetan')
      end
    end
  end
end
