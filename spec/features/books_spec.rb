require 'spec_helper'

feature '蔵書', js: true do
  # collection で作る本のタイトルは、"ステキな本#{i}"
  let!(:collection1) { create(:collection, :collection_whatever) }
  let!(:collection2) { create(:collection, :collection_whatever) }
  let!(:collection3) { create(:collection, :collection_whatever) }
  let!(:collection4) { create(:collection, :collection_whatever) }
  let!(:collection5) { create(:collection, :collection_whatever) }
  let!(:collection6) { create(:collection, :collection_whatever) }
  let!(:collection7) { create(:collection, :collection_whatever) }
  let!(:collection8) { create(:collection, :collection_whatever) }

  background do
    visit books_path
  end

  context '蔵書一覧ページ' do
    scenario '新着順に7つの蔵書、所有者が表示され、ページングされる' do
      expect(page).to have_css('h2', text: '蔵書一覧')

      expect(page).to have_css('.book-box', count: 7)

      els = all(:css, '.book-box')
      expect(els[0].find('.content-title a')).to have_content(collection8.book.title)
      expect(els[1].find('.content-title a')).to have_content(collection7.book.title)
      expect(els[2].find('.content-title a')).to have_content(collection6.book.title)
      expect(els[3].find('.content-title a')).to have_content(collection5.book.title)
      expect(els[4].find('.content-title a')).to have_content(collection4.book.title)
      expect(els[5].find('.content-title a')).to have_content(collection3.book.title)
      expect(els[6].find('.content-title a')).to have_content(collection2.book.title)

      expect(els[0].find('.user-images img')['title']).to have_content(collection8.user.name)
      expect(els[1].find('.user-images img')['title']).to have_content(collection7.user.name)
      expect(els[2].find('.user-images img')['title']).to have_content(collection6.user.name)
      expect(els[3].find('.user-images img')['title']).to have_content(collection5.user.name)
      expect(els[4].find('.user-images img')['title']).to have_content(collection4.user.name)
      expect(els[5].find('.user-images img')['title']).to have_content(collection3.user.name)
      expect(els[6].find('.user-images img')['title']).to have_content(collection2.user.name)

      click_link '2'

      expect(page).to have_css('.book-box', count: 1)

      expect(page).to have_css('.book-box .content-title:nth-child(1)', text: collection1.book.title)
      expect(page.find('.user-images img')['title']).to have_content(collection1.user.name)
    end
  end

  context '蔵書詳細ページ' do
    scenario 'タイトルをクリックすると詳細ページに遷移して必要項目が表示される' do
      expect(page).to have_css('h2', text: '蔵書一覧')

      click_link collection8.book.title

      expect(page).to have_css('h2', text: collection8.book.title)
      expect(page.find('.user-images img')['title']).to have_content(collection8.user.name)
    end

    scenario 'ログインしていない場合、詳細ページの感想を書くボタンでログインページに遷移する' do
      expect(page).to have_css('h2', text: '蔵書一覧')

      click_link collection8.book.title

      click_link 'この本の感想を書く'

      expect(page).to have_css('h2', text: 'ログイン')
    end

    context 'ログインしている場合' do
      include_context 'ユーザーとしてログインしている'

      scenario '詳細ページの感想を書くボタンで、reviewページに遷移する'do
        visit books_path

        click_link collection8.book.title

        click_link 'この本の感想を書く'

      expect(page).to have_css('h2', text: '読書感想 投稿')
        expect(find_field('Book').value).to eq collection8.book.id.to_s
      end
    end
  end
end
