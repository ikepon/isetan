require 'spec_helper'

feature '読書感想', js: true do
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

  context '感想詳細ページ' do
    include_context 'ユーザーとしてログインしている'

    let!(:review) { create(:review, :review_whatever, title: '最高の本') }

    background do
      visit reviews_path
    end

    scenario '詳細ページに遷移して、必要項目が表示されている' do
      expect(page).to have_css('h2', text: '読書感想一覧')

      click_link '最高の本'

      expect(page).to have_css('h2', text: '最高の本')
      expect(page).to have_css('h3', text: review.book.title)
      expect(page).to have_content(review.user.name)
      expect(page).to have_content(review.content)
    end

    scenario 'ログインしているユーザが書いた感想の編集ボタンは本人のみ表示される' do
      create(:review, :review_whatever, title: 'ログインユーザの感想', user_id: current_user.id)

      click_link '最高の本'

      expect(page).not_to have_css('a.edit-btn', text: '編集')

      click_link '読書感想'
      click_link 'ログインユーザの感想'

      expect(page).to have_css('a.edit-btn', text: '編集')
    end
  end
end