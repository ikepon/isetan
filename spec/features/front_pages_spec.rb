require 'spec_helper'

feature "トップページ" do
  context "ログイン前トップページの表示" do
    let!(:review1) { create(:review, :review_whatever, title: 'すてきな本でした') }
    let!(:review2) { create(:review, :review_whatever, title: 'おもしろい本でした') }
    let!(:review3) { create(:review, :review_whatever, title: '最高の本でした') }

    background do
      visit root_path
    end

    scenario "サイトタイトルが表示されいている" do
      expect(page).to have_css('.navbar-brand', text: 'Isetan')
    end

    scenario "グローバルナビのメニューが表示されている" do
      expect(page).to have_css('ul.nav.navbar-nav li', text: '読書感想')
      expect(page).to have_css('ul.nav.navbar-nav li', text: '蔵書')
      # expect(page).to have_css('ul.nav.navbar-nav li', text: '予約')
      expect(page).to have_css('ul.nav.navbar-nav li', text: 'Users')
      expect(page).to have_css('ul.nav.navbar-nav li', text: 'お問合せ')
      expect(page).to have_css('ul.nav.navbar-nav li', text: 'Login')
    end

    scenario "メインビューにタイトル、ボタンが表示されている" do
      expect(page).to have_css('.view-title', text: '蔵書管理 isetan')
      expect(page).to have_content('ユーザー登録')
      expect(page).to have_content('ログイン')
    end

    scenario "ユーザー登録ボタンをクリックすると、登録ページに遷移すること" do
      click_link 'ユーザー登録'
      expect(page).to have_css('h2', text: 'ユーザー登録')
    end

    scenario "ログインボタンをクリックすると、ログインページに遷移する" do
      expect(page).to have_css('.view-title', text: '蔵書管理 isetan')
      click_link 'ログイン'
      expect(page).to have_css('h2', text: 'ログイン')
    end

    scenario "最新のreviewが2件表示されている" do
      expect(page).to have_css('.content-title', text: '最高の本でした')
      expect(page).to have_css('.content-title', text: 'おもしろい本でした')
      expect(page).not_to have_css('.content-title', text: 'すてきな本でした')
    end

    context "サイドバー領域に必要コンテンツが表示されている" do
      let!(:news1) { create(:news, title: 'review機能実装', created_at: DateTime.new(2050, 11, 02)) }
      let!(:news2) { create(:news, title: 'news機能実装', created_at: DateTime.new(2050, 11, 22)) }
      let!(:news3) { create(:news, title: '蔵書機能実装', created_at: DateTime.new(2050, 11, 25)) }
      let!(:news4) { create(:news, title: 'user登録機能実装', created_at: DateTime.new(2050, 11, 27)) }

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
  context "ログイントップページの表示" do
    include_context 'ユーザーとしてログインしている'

    background do
      visit root_path
    end

    scenario "メインビューにボタンが表示されている" do
      expect(page).to have_content('感想を見る')
      expect(page).to have_content('感想を書く')
    end

    scenario "感想を見るボタンをクリックすると、感想一覧に遷移すること" do
      click_link '感想を見る'
      expect(page).to have_css('h2', text: '読書感想一覧')
    end

    scenario "感想を書くボタンをクリックすると、感想投稿ページに遷移する" do
      click_link '感想を書く'
      expect(page).to have_css('h2', text: '読書感想 投稿')
    end
  end

  # TODO フッターの遷移テスト作成
end
