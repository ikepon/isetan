require 'spec_helper'

feature "トップページ" do
  context "ログイン前トップページの表示" do
    background do
      visit root_path
    end

    scenario "アプリタイトルが表示されいている" do
      expect(page).to have_css('.navbar-brand', text: 'Isetan')
    end

    scenario "navbarのメニューが表示されている" do
      expect(page).to have_css('ul.nav.navbar-nav li', text: 'Hot')
      expect(page).to have_css('ul.nav.navbar-nav li', text: 'New')
      expect(page).to have_css('ul.nav.navbar-nav li', text: '予約')
      expect(page).to have_css('ul.nav.navbar-nav li', text: 'お問合せ')
      expect(page).to have_css('ul.nav.navbar-nav li', text: 'Login')
    end

    scenario "メインビューが表示されている" do
      expect(page).to have_css('.view-title', text: '蔵書管理 isetan')
    end

    scenario "メイン領域に必要コンテンツが表示されている" do
      expect(page).to have_css('.content-title', text: 'Hot No1')
      expect(page).to have_css('.content-title', text: 'Hot No2')

      expect(page).to have_css('.content-title', text: 'New No1')
      expect(page).to have_css('.content-title', text: 'New No2')
    end

    scenario "サイドバー領域に必要コンテンツが表示されている" do
      expect(page).to have_css('.content-title', text: 'News')
    end

    scenario "フッター領域に必要コンテンツが表示されている" do
      expect(page).to have_css('footer', text: 'サイトについて')
      expect(page).to have_css('footer', text: 'お問合せ')
      expect(page).to have_css('footer', text: '運営者')
    end
  end
end
