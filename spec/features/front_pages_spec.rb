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

    context "サイドバー領域に必要コンテンツが表示されている" do
      let!(:news1) { create(:news, created_at: DateTime.new(2050, 11, 02)) }
      let!(:news2) { create(:news, created_at: DateTime.new(2050, 11, 22)) }
      let!(:news3) { create(:news, created_at: DateTime.new(2050, 11, 25)) }
      let!(:news4) { create(:news, created_at: DateTime.new(2050, 11, 27)) }

      background do
        visit root_path
      end

      scenario '最新の3件のニュースが表示されている' do
        within '#sidebar' do
          expect(page).to have_css('.content-title', text: 'News')
          expect(page).not_to have_css('.news-title', text: news1.title)
          expect(page).to have_css('.news-title', text: news2.title)
          expect(page).to have_css('.news-title', text: news3.title)
          expect(page).to have_css('.news-title', text: news4.title)
        end
      end

      scenario 'ニュース一覧ページに遷移する' do
        within '#sidebar' do
          click_link 'News一覧へ'
        end
        expect(page).to have_css('h2', text: 'News 一覧')
      end
    end

    scenario "フッター領域に必要コンテンツが表示されている" do
      expect(page).to have_css('footer', text: 'サイトについて')
      expect(page).to have_css('footer', text: 'お問合せ')
      expect(page).to have_css('footer', text: '運営者')
    end
  end
end
