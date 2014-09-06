require 'spec_helper'

feature "User ページ" do
  context "ユーザ一覧ページ" do
    background do
      visit users_path
    end

    scenario "ユーザ一覧ページに遷移すること" do
      expect(page).to have_css('h2', text: 'ユーザ一覧')
    end
  end
end
