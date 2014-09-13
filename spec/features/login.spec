require 'spec_helper'

feature 'ユーザー作成、ログイン、ログアウト' do
  context 'ユーザー作成する' do
    before do
      visit signup_path
    end

    scenario '新規ユーザーの作成' do
      fill_in 'user[name]', with: 'test user'
      fill_in 'user[email]', with: 'test@example.com'
      fill_in 'user[password_digest]', with: 'password'
      fill_in 'user[password_confirmation', with: 'password'
      click_on 'ユーザーを作成する'

      expect(page).to have_css('h2', text: 'プロフィール')
      expect(page).to have_css('.user-name', text: 'test user')
    end
  end

  context 'ログインする' do
    let!(:user) { create(:user) }

    before do
      visit login_path
    end

    scenario '正しい情報を入れるとログインできる' do
      fill_in 'user[email]', with: 'user1@example.com'
      fill_in 'user[password_digest]', with: 'user_password'
      click_on 'ログインする'

      expect(page).to have_css('.user-name', text: 'user_name1')
    end

    scenario '間違ったemailを入れるとログインできない' do
      fill_in 'user[email]', with: 'other@example.com'
      fill_in 'user[password_digest]', with: 'user_password'

      click_on 'ログインする'

      expect(page).to have_css('.alert', text: '入力情報に誤りがあります。')
    end

    scenario '間違ったpasswordを入れるとログインできない' do
      fill_in 'user[email]', with: 'user1@example.com'
      fill_in 'user[password_digest]', with: 'other_password'

      click_on 'ログインする'

      expect(page).to have_css('.alert', text: '入力情報に誤りがあります。')
    end

    context 'ログアウトする' do
      scenario 'ログインした状態で、ログアウトする' do
        include_context 'ユーザーとしてログインしている'

        within '.nav' do
          click_on 'logout'
        end

        expect(page).to have_css('h2', text: '蔵書管理 isetan')
      end
    end
  end
end
