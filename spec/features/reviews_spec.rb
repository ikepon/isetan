require 'spec_helper'

feature '読書感想ページ', js: true do
  context '感想一覧ページ' do
    include_context 'ユーザーとしてログインしている'

    background do
      1.upto(7).each do |i|
        create(:review, :review_whatever, title: "素敵な本#{i}")
      end

      create(:review, :review_whatever, title: '最高の本', user_id: current_user.id)

      visit reviews_path
    end

    scenario '一覧ページでは新着順に7つの感想が表示されページングされる' do
      expect(page).to have_css('h2', text: '読書感想一覧')

      expect(page).to have_css('.book-box', count: 7)

      els = all(:css, '.book-box .content-title')
      expect(els[0].find('a')).to have_content('最高の本')
      expect(els[1].find('a')).to have_content('素敵な本7')
      expect(els[2].find('a')).to have_content('素敵な本6')
      expect(els[3].find('a')).to have_content('素敵な本5')
      expect(els[4].find('a')).to have_content('素敵な本4')
      expect(els[5].find('a')).to have_content('素敵な本3')
      expect(els[6].find('a')).to have_content('素敵な本2')

      click_link '2'

      expect(page).to have_css('.book-box', count: 1)

      expect(page).to have_css('.book-box .content-title:nth-child(1)', text: '素敵な本1')
    end

    scenario 'ログインユーザーの書いたレビューのみ編集できる' do
      within '#contents' do
        expect(page).to have_css('a.edit-btn', count: 1)

        click_link '編集'

        expect(page).to have_css('h2', text: '読書感想 編集')

        expect(find_field('Title').value).to eq '最高の本'
      end
    end
  end
end