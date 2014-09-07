require 'spec_helper'

feature "User ページ" do
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

    context "ユーザー詳細ページ" do
      background do
        visit user_path(user)
      end

      scenario "ユーザの詳細が表示されいてる" do
        expect(page).to have_css('.user-name', text: "#{user.name}")
        expect(page).to have_css('.user-profile', text: "#{user.profile}")
      end

    end
  end
end
