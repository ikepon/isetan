require 'spec_helper'

feature 'Userページ' do
  context 'ログイン前' do
    background do
      1.upto(8).each do |i|
        create(:user, name: "user#{i}")
      end
    end

    scenario 'ヘッダーメニューから遷移してユーザー一覧が表示されること' do
      visit root_path

      click_link 'Users'

      expect(page).to have_css('h2', text: 'ユーザ一覧')
    end

    scenario '一覧ページは7名でページングして表示される' do
      visit users_path

      expect(page).to have_css('h2', text: 'ユーザ一覧')
      expect(page).to have_css('tbody tr', count: 7)

      els = all(:css, 'tbody tr')
      expect(els[0].find('.user-name')).to have_content('user8')
      expect(els[1].find('.user-name')).to have_content('user7')
      expect(els[2].find('.user-name')).to have_content('user6')
      expect(els[3].find('.user-name')).to have_content('user5')
      expect(els[4].find('.user-name')).to have_content('user4')
      expect(els[5].find('.user-name')).to have_content('user3')
      expect(els[6].find('.user-name')).to have_content('user2')

      click_link '2'

      expect(page).to have_css('tbody tr', count: 1)
      expect(page).to have_css('.user-name', text: 'user1')
    end

    scenario '一覧ページからユーザネームをクリックして詳細ページに遷移する' do
      visit users_path

      click_link 'user8'

      expect(page).to have_css('h2', text: 'プロフィール')
      expect(page).to have_css('.user-name', text: 'user8')

      click_link 'ユーザ一覧に戻る'

      expect(page).to have_css('h2', text: 'ユーザ一覧')
    end
  end

  context 'ログイン後' do
    include_context 'ユーザーとしてログインしている'

    let!(:other_user) { create(:user, name: 'other user') }

    scenario 'ログイン直後はユーザ詳細ページが表示されること' do
      expect(page).to have_css('h2', text: 'プロフィール')
      expect(page).to have_css('.user-name', text: current_user.name)
      expect(page).to have_css('.user-profile', text: current_user.profile)
    end

    scenario '自分のプロフィール編集画面に遷移し、他の人の編集ページに遷移しようとするとTOPに遷移すること' do

      click_on 'プロフィールを編集する'

      expect(page).to have_css('h2', text: 'プロフィール編集')

      click_link 'Users'

      click_link 'other user'

      expect(page).not_to have_css('.btn.btn-default', text: 'プロフィール編集')

      visit edit_user_path(other_user)
      expect(page).to have_css('.navbar-brand', text: 'Isetan')
    end

    context 'ユーザ編集ページ' do
      background do
        visit edit_user_path(current_user)
      end

      scenario 'ユーザー情報を変更すると保存されること' do
        fill_in 'user[name]', with: 'super user'

        click_on '登録する'

        expect(page).to have_css('h2', text: 'プロフィール')
        expect(page).to have_css('.alert-success', text: 'プロフィールを更新しました')
        expect(page).to have_css('.user-name', text: 'super user')
      end

      scenario 'ユーザ名が51文字以上の場合、画面が遷移せず、エラーメッセージが表示される' do
        fill_in 'user[name]', with: 'a' * 51
        fill_in 'user[email]', with: 'user@example.com'
        fill_in 'user[password]', with: 'a' * 10
        fill_in 'user[password_confirmation]', with: 'a' * 10
        click_on '登録する'

        expect(page).to have_css('h2', text: 'プロフィール編集')
        expect(page).to have_css('.alert', text: 'Name is too long (maximum is 50 characters)')
      end
    end
  end
end
