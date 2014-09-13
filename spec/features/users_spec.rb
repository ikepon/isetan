require 'spec_helper'

feature "User ページ" do
  context 'ユーザー作成する' do
    before do
      visit signup_path
    end

    scenario '新規ユーザーの作成' do
      fill_in 'user[name]', with: 'test user'
      fill_in 'user[email]', with: 'test@example.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_on '登録する'

      expect(page).to have_css('h2', text: 'プロフィール')
      expect(page).to have_css('.user-name', text: 'test user')
    end
  end

  context "ユーザ一覧ページ" do
    let!(:user) { create(:user) }

    background do
      visit users_path
    end

    scenario "ユーザ一覧ページに遷移すること" do
      expect(page).to have_css('h2', text: 'ユーザ一覧')
    end

    scenario "ユーザが表示されていること" do
      expect(page).to have_css('.user-id', text: "#{user.id}")
      expect(page).to have_css('.user-name', text: "#{user.name}")
    end

    scenario "ユーザ詳細ページに遷移すること" do
      click_on 'プロフィールへ'

      expect(page).to have_css('h2', text: "プロフィール")
    end

    context "ユーザ詳細ページ" do
      background do
        visit user_path(user)
      end

      scenario "ユーザの詳細が表示されいてる" do
        expect(page).to have_css('.user-name', text: "#{user.name}")
        expect(page).to have_css('.user-profile', text: "#{user.profile}")
      end

      scenario "ユーザ一覧に戻るボタンを押すとユーザ一覧ページに遷移する" do
        click_on 'ユーザ一覧に戻る'

        expect(page).to have_css('h2', "ユーザ一覧")
      end

      scenario "プロフィール編集が面に遷移すること" do
        click_on 'プロフィールを編集する'

        expect(page).to have_css('h2', text: "プロフィール編集")
      end
    end

    context "ユーザ編集ページ" do
      background do
        visit edit_user_path(user)
      end

      scenario "ユーザの編集画面が表示されいてる" do
        expect(page).to have_css('h2', text: "プロフィール編集")
      end

      scenario "ユーザ名が51文字以上の場合、画面が遷移せず、エラーメッセージが表示される" do
        fill_in 'user[name]', with: "a" * 51
        fill_in 'user[email]', with: "user@example.com"
        fill_in 'user[password]', with: "a" * 10
        fill_in 'user[password_confirmation]', with: "a" * 10
        click_on '登録する'

        expect(page).to have_css('h2', text: "プロフィール編集")
        expect(page).to have_css('.alert', text: "Name is too long (maximum is 50 characters)")
      end
    end
  end
end
