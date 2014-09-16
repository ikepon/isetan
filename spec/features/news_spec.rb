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
      expect(page).to have_css('.date', text: '50.11.02')
      expect(page).to have_css('.title', text: 'Title1')
      expect(page).to have_css('.date', text: '50.11.22')
      expect(page).to have_css('.title', text: 'Title2')
      expect(page).to have_css('.date', text: '50.11.25')
      expect(page).to have_css('.title', text: 'Title3')
      expect(page).to have_css('.date', text: '50.11.27')
      expect(page).to have_css('.title', text: 'Title4')
    end

    scenario 'タイトルをクリックすると詳細ページに遷移する' do
      click_link 'Title1'

      expect(page).to have_css('.title', text: 'Title1')
      expect(page).to have_css('.date', text: '50.11.02')
      expect(page).to have_css('.content', text: 'Content1content1content1content1content1content1content1content1content1content1content1content1content1')
    end
  end
end
