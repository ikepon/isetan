require 'spec_helper'

feature 'お問い合わせページ', js: true do
  scenario 'TOPページからお問い合わせページに遷移できる' do
    visit root_path

    within '.navbar-collapse' do
      click_link 'お問合せ'
    end

    expect(page).to have_css('h2', text: 'お問合せ')
  end

  context 'お問合せをする' do
    background do
      visit new_contact_path
    end

    scenario 'お問合せできる' do
      expect(page).to have_css('h2', text: 'お問合せ')

      choose '機能について'
      fill_in 'Name', with: 'カミナ'
      fill_in 'Email', with: 'test@example.com'
      fill_in 'Content', with: 'もっとおもしろい機能を追加してほしい'

      click_on '確認する'

      expect(page).to have_css('h2', text: 'お問合せ内容の確認')
      expect(page).to have_content('カミナ')
      expect(page).to have_content('test@example.com')
      expect(page).to have_content('もっとおもしろい機能を追加してほしい')

      click_on '送信する'

      expect(page).to have_css('h2', text: 'お問合せ完了')
      expect(page).to have_css('.alert.alert-success', text: 'お問合せが完了しました')

      click_link 'TOPページに戻る'

      expect(page).to have_css('.navbar-brand', text: 'Isetan')
    end

    scenario '空白のまま確認ボタンを押すとエラーがでる' do
      click_on '確認する'

      expect(page).to have_css('h2', text: 'お問合せ')

      within '.alert.alert-danger' do
        expect(page).to have_content('Nameを入力してください。')
        expect(page).to have_content('Emailを入力してください。')
        expect(page).to have_content('Contentを入力してください。')
      end
    end

    scenario '名前が50文字、メールアドレスが255文字より多い場合はエラーがでる' do
      fill_in 'Name', with: 'a' * 56
      fill_in 'Email', with: 'a' * 256

      click_on '確認する'

      expect(page).to have_css('h2', text: 'お問合せ')

      within '.alert.alert-danger' do
        expect(page).to have_content('Nameは50文字以内で入力してください。')
        expect(page).to have_content('Emailは255文字以内で入力してください。')
      end

    end
  end
end
