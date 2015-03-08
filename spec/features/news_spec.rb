require 'spec_helper'

feature 'Newsページ' do
  context 'TOPページの表示' do
    let!(:news1) { create(:news, created_at: DateTime.new(2050, 11, 02)) }
    let!(:news2) { create(:news, created_at: DateTime.new(2050, 11, 22)) }
    let!(:news3) { create(:news, created_at: DateTime.new(2050, 11, 25)) }
    let!(:news4) { create(:news, created_at: DateTime.new(2050, 11, 27)) }

    scenario 'TOPページのサイドバーだけに最新3件のNewsが表示される' do
      visit root_path

      within '#sidebar' do
        expect(page).to have_css('h3', text: 'News')

        expect(page).to have_css('.news-date', text: '2050/11/27')
        expect(page).to have_css('.news-title', text: news4.title)
        expect(page).to have_css('.news-date', text: '2050/11/25')
        expect(page).to have_css('.news-title', text: news3.title)
        expect(page).to have_css('.news-date', text: '2050/11/22')
        expect(page).to have_css('.news-title', text: news2.title)
        expect(page).not_to have_css('.news-date', text: '2050/11/02')
        expect(page).not_to have_css('.news-title', text: news1.title)
      end

      click_link '読書感想'

      within '#sidebar' do
        expect(page).not_to have_css('h3', text: 'News')
      end

      click_link 'みんなの蔵書'

      within '#sidebar' do
        expect(page).not_to have_css('h3', text: 'News')
      end

      within '.navbar-collapse' do
        click_link 'お問合せ'
      end

      within '#sidebar' do
        expect(page).not_to have_css('h3', text: 'News')
      end

      click_link 'Login'

      within '#sidebar' do
        expect(page).not_to have_css('h3', text: 'News')
      end
    end

    scenario 'タイトル、日付一覧が表示されている' do
      visit root_path

      click_link 'News一覧へ'

      expect(page).to have_css('.news-date', text: '2050/11/27')
      expect(page).to have_css('.news-title', text: news4.title)
      expect(page).to have_css('.news-date', text: '2050/11/25')
      expect(page).to have_css('.news-title', text: news3.title)
      expect(page).to have_css('.news-date', text: '2050/11/22')
      expect(page).to have_css('.news-title', text: news2.title)
      expect(page).to have_css('.news-date', text: '2050/11/02')
      expect(page).to have_css('.news-title', text: news1.title)
    end

    scenario 'タイトルをクリックすると詳細ページに遷移する' do
      visit news_index_path

      click_link news1.title

      expect(page).to have_css('h2', text: news1.title)
      expect(page).to have_css('span.small', text: news1.created_at.to_formatted_s(:date))
      expect(page).to have_css('.news-content', text: news1.content)

      click_link 'ニュース一覧に戻る'

      expect(page).to have_css('h2', text: 'News 一覧')
    end
  end
end
