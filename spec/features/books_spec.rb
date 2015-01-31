require 'spec_helper'

feature '蔵書', js: true do
  context '蔵書一覧ページ' do
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

    scenario '新着順に7つの蔵書、所有者が表示され、ページングされる' do
      expect(page).to have_css('h2', text: '蔵書一覧')

      expect(page).to have_css('.book-box', count: 7)

      els = all(:css, '.book-box')
      expect(els[0].find('.content-title a')).to have_content('ステキな本8')
      expect(els[0].find('.user-images img')['title']).to have_content("#{collection8.user.name}")
      expect(els[1].find('.content-title a')).to have_content('ステキな本7')
      expect(els[1].find('.user-images img')['title']).to have_content("#{collection7.user.name}")
      expect(els[2].find('.content-title a')).to have_content('ステキな本6')
      expect(els[2].find('.user-images img')['title']).to have_content("#{collection6.user.name}")
      expect(els[3].find('.content-title a')).to have_content('ステキな本5')
      expect(els[3].find('.user-images img')['title']).to have_content("#{collection5.user.name}")
      expect(els[4].find('.content-title a')).to have_content('ステキな本4')
      expect(els[4].find('.user-images img')['title']).to have_content("#{collection4.user.name}")
      expect(els[5].find('.content-title a')).to have_content('ステキな本3')
      expect(els[5].find('.user-images img')['title']).to have_content("#{collection3.user.name}")
      expect(els[6].find('.content-title a')).to have_content('ステキな本2')
      expect(els[6].find('.user-images img')['title']).to have_content("#{collection2.user.name}")

      click_link '2'

      expect(page).to have_css('.book-box', count: 1)

      expect(page).to have_css('.book-box .content-title:nth-child(1)', text: 'ステキな本1')
      expect(page.find('.user-images img')['title']).to have_content(collection1.user.name)
    end
  end
end
