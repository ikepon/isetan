require 'spec_helper'

feature 'ログイン、ログアウト', js: true do
  context 'ログインする' do
    let!(:user) { create(:user) }

    background do
      visit login_path
    end

    scenario '正しい情報を入れるとログインできる' do
      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      within '.login' do
        click_on 'Login'
      end

      expect(page).to have_css('h2', text: 'ホーム')
      expect(page).to have_xpath("//input[@id='user_name'][@value='#{user.name}']")
    end

    scenario '間違ったemailを入れるとログインできない' do
      fill_in 'session[email]', with: 'other@example.com'
      fill_in 'session[password]', with: user.password

      within '.login' do
        click_on 'Login'
      end

      expect(page).to have_css('.alert', text: 'メールアドレス、パスワードの組み合わせに誤りがあります。')
    end

    scenario '間違ったpasswordを入れるとログインできない' do
      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: 'other_password'

      within '.login' do
        click_on 'Login'
      end

      expect(page).to have_css('.alert', text: 'メールアドレス、パスワードの組み合わせに誤りがあります。')
    end
  end

  context 'ログアウトする' do
    include_context 'ユーザーとしてログインしている'

    scenario 'ログインした状態で、ログアウトする' do
      find('.navbar-right a', text: 'Logout').click

      expect(page).to have_css('h2', text: '蔵書管理 isetan')
    end
  end
end
