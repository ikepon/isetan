require 'spec_helper'

feature 'Newsページ' do
  context 'News一覧ページを表示' do
    let!(:news1) { create(:news, created_at: DateTime.new(2050, 11, 02)) }
    let!(:news2) { create(:news, created_at: DateTime.new(2050, 11, 22)) }
    let!(:news3) { create(:news, created_at: DateTime.new(2050, 11, 25)) }
    let!(:news4) { create(:news, created_at: DateTime.new(2050, 11, 27)) }

    before do
      visit news_index_path
    end

    scenario 'タイトル、日付一覧が表示されている' do
      expect(page).to have_css('.news-date', text: news1.created_at.to_formatted_s(:date))
      expect(page).to have_css('.news-title', text: news1.title)
      expect(page).to have_css('.news-date', text: news2.created_at.to_formatted_s(:date))
      expect(page).to have_css('.news-title', text: news2.title)
      expect(page).to have_css('.news-date', text: news3.created_at.to_formatted_s(:date))
      expect(page).to have_css('.news-title', text: news3.title)
      expect(page).to have_css('.news-date', text: news4.created_at.to_formatted_s(:date))
      expect(page).to have_css('.news-title', text: news4.title)
    end

    scenario 'タイトルをクリックすると詳細ページに遷移する' do
      click_link news1.title

      expect(page).to have_css('.news-title', text: news1.title)
      expect(page).to have_css('.news-date', text: news1.created_at.to_formatted_s(:date))
      expect(page).to have_css('.news-content', text: news1.content)
    end
  end
end
