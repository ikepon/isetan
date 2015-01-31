require 'spec_helper'

feature '蔵書管理' do
  pending 'collectionの扱いが決まるまでpendingします' do
  scenario 'TOPページからの蔵書ページに遷移する' do
    visit root_path

    click_link '蔵書'

    expect(page).to have_css('h2', text: '蔵書一覧')
  end

  context '蔵書一覧ページに遷移' do
    let!(:book_a) { create(:book) }
    let!(:book_b) { create(:book) }
    let!(:book_c) { create(:book) }

    let!(:collection_a) { create(:collection, book: book_a) }
    let!(:collection_b) { create(:collection, book: book_b) }
    let!(:collection_c) { create(:collection, book: book_c) }

    background do
      visit collections_path
    end

    scenario '蔵書一覧が表示されている' do
      expect(page).to have_css('.title', text: collection_a.book.title)
      expect(page).to have_css('.wanted', text: collection_a.book.wanted)
      expect(page).to have_css('.read', text: collection_a.book.read)
      expect(page).to have_css('.rental', text: collection_a.book.rental)

      expect(page).to have_css('.title', text: collection_b.book.title)
      expect(page).to have_css('.wanted', text: collection_b.book.wanted)
      expect(page).to have_css('.read', text: collection_b.book.read)
      expect(page).to have_css('.rental', text: collection_b.book.rental)

      expect(page).to have_css('.title', text: collection_c.book.title)
      expect(page).to have_css('.wanted', text: collection_c.book.wanted)
      expect(page).to have_css('.read', text: collection_c.book.read)
      expect(page).to have_css('.rental', text: collection_c.book.rental)
    end

    scenario '蔵書詳細ページに遷移し、該当書籍が表示されている' do
      click_link collection_a.book.title

      expect(page).to have_css('h2', text: collection_a.book.title)
      expect(page).to have_css('.wanted', text: collection_a.book.wanted)
      expect(page).to have_css('.read', text: collection_a.book.read)
      expect(page).to have_css('.rental', text: collection_a.book.rental)
    end

    # TODO HOT, NEW とかが出てきたらテスト書く
    # 予約機能実装時にテスト書く
  end
  end
end
