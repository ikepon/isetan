require 'spec_helper'

feature '蔵書', js: true do
  # collection で作る本のタイトルは、'ステキな本#{i}'
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

      within '#contents' do
        click_link collection8.book.title
      end

      expect(page).to have_css('h2', text: collection8.book.title)
      expect(page.find('.user-images img')['title']).to have_content(collection8.user.name)
    end
  end

  pending 'アマゾンの検索でエラーになるので、一旦保留' do
  context '蔵書登録ページ' do
    # TODO collections_spec を作ったら、このテストをどこに置くのか検討
    include_context 'ユーザーとしてログインしている'

    background do
      visit new_collection_path
    end

    scenario '新規の蔵書を登録し、同じ本を登録しようとするとエラーになる' do
      expect(page).to have_css('h2', text: '蔵書登録')

      fill_in 'asin', with: '4839941874'

      click_on '登録する'

      expect(page).to have_css('h2', text: '登録する本の確認')
      within '#new_book' do
        expect(page).to have_content('4839941874')
        expect(page).to have_content('よくわかるJavaScriptの教科書')
      end

      click_on '登録する'

      expect(page).to have_css('h2', text: 'よくわかるJavaScriptの教科書')
      expect(page).to have_css('.alert.alert-success', text: '蔵書登録しました')
      expect(page.find('.user-images img')['title']).to have_content(current_user.name)

      # ここからエラーチェック
      visit new_collection_path

      fill_in 'asin', with: '4839941874'

      click_on '登録する'

      expect(page).to have_css('h2', text: '蔵書登録')
      expect(page).to have_css('.alert.alert-danger', text: '既に蔵書登録されています。')
    end

    scenario '適当なASINコードを入力するとエラーになる' do
      fill_in 'asin', with: '1234567890'

      click_on '登録する'

      expect(page).to have_css('h2', text: '蔵書登録')
      expect(page).to have_css('.alert.alert-danger', text: '入力いただいたASINコードに該当する本はありません。')
    end
  end
  end

end
