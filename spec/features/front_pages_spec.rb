require 'spec_helper'

feature "トップページ", js: true do
  context "ログイン前トップページの表示" do
    scenario "アプリタイトルが表示されいている" do
      expect(page).to have_css('.navbar-brand', text: 'Isetan')
    end

    scenario "navbarのメニューが表示されている" do
      expect(page).to have_css('ul.navbar li', text: 'Hot')
      expect(page).to have_css('ul.navbar li', text: 'New')
      expect(page).to have_css('ul.navbar li', text: '予約')
      expect(page).to have_css('ul.navbar li', text: 'お問合せ')
      expect(page).to have_css('ul.navbar li', text: 'Login')
    end

    scenario "メイン領域に必要コンテンツが表示されている" do
      expect(page).to have_css('h2', text: 'Hot Books')
      expect(page).to have_css('.col-md-4', text: 'Hot No1')
      expect(page).to have_css('.col-md-4', text: 'Hot No2')
      expect(page).to have_css('.col-md-4', text: 'Hot No3')

      expect(page).to have_css('h2', text: 'new Books')
      expect(page).to have_css('.col-md-4', text: 'New No1')
      expect(page).to have_css('.col-md-4', text: 'New No2')
      expect(page).to have_css('.col-md-4', text: 'New No3')
    end

    scenario "サイドバー領域に必要コンテンツが表示されている" do
      expect(page).to have_css('.h3', text: 'News')
    end

    scenario "フッター領域に必要コンテンツが表示されている" do
      expect(page).to have_css('footer', text: 'サイトについて')
      expect(page).to have_css('footer', text: 'お問合せ')
      expect(page).to have_css('footer', text: '運営者')
    end
  end
end
