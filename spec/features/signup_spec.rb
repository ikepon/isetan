require 'spec_helper'

feature 'サインアップ' do
  let!(:user) { create(:user, email: 'user@example.com') }

  scenario 'ログイン畫面から遷移して、ユーザー登録できる' do
    visit login_path

    click_on 'ユーザー登録する'

    expect(page).to have_css('h2', text: 'ユーザー登録')

    fill_in 'user[name]', with: 'signup_user'
    fill_in 'user[email]', with: 'signup_user@example.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'

    click_on '登録する'

    expect(page).to have_css('h2', text: 'プロフィール')
    expect(page).to have_css('.user-name', text: 'signup_user')
  end

  scenario 'パスワードが6文字未満の場合、エラーがでる' do
    visit signup_path

    expect(page).to have_css('h2', text: 'ユーザー登録')

    fill_in 'user[name]', with: 'signup_user'
    fill_in 'user[email]', with: 'signup_user@example.com'
    fill_in 'user[password]', with: 'pass'
    fill_in 'user[password_confirmation]', with: 'pass'

    click_on '登録する'

    expect(page).to have_css('h2', text: 'ユーザー登録')
    expect(page).to have_content("Password is too short (minimum is 6 characters)")
  end

  scenario 'パスワードがconfirmと一致しないとエラーがでる' do
    visit signup_path

    expect(page).to have_css('h2', text: 'ユーザー登録')

    fill_in 'user[name]', with: 'signup_user'
    fill_in 'user[email]', with: 'signup_user@example.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'other_password'

    click_on '登録する'

    expect(page).to have_css('h2', text: 'ユーザー登録')
    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  scenario '既に登録されたemailの場合、エラーがでる' do
    visit signup_path

    expect(page).to have_css('h2', text: 'ユーザー登録')

    fill_in 'user[name]', with: 'signup_user'
    fill_in 'user[email]', with: 'user@example.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'

    click_on '登録する'

    expect(page).to have_css('h2', text: 'ユーザー登録')
    expect(page).to have_content("Email has already been taken")
  end
end
