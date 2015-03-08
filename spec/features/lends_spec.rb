require 'spec_helper'

feature '本の貸出ページ' do
  let!(:user) { create(:user, name: 'user') }
  let!(:company) { create(:user, name: 'company', role: 2) }
  let!(:borrower) { create(:user, name: 'borrower') }

  let!(:book1) { create(:book, title: '貸し出さない本') }
  let!(:book2) { create(:book, title: 'レンタル本１') }
  let!(:book3) { create(:book, title: 'レンタル本２') }
  let!(:book4) { create(:book, title: 'レンタル本３') }
  let!(:no_rental_collection) { create(:collection, status: 0, user: user, book: book1) }
  let!(:reservable_collection) { create(:collection, status: 1, user: company, book: book2) }
  let!(:rented_collection) { create(:collection, status: 2, rented_at: Time.zone.now - 7.days, returned_at: Time.zone.now, user: company, book: book3, borrower: borrower) }
  let!(:expired_collection) { create(:collection, status: 3, rented_at: Time.zone.now - 7.days, returned_at: Time.zone.now - 1.days, user: company, book: book4, borrower: borrower) }

  context 'ログイン前' do
    scenario 'レンタル用の本一覧が表示される' do
      visit root_path

      expect(page).to have_css('.view-title', text: '蔵書管理 isetan')

      click_link '本の貸出'

      expect(page).to have_css('h2', text: '本の貸出')
      expect(page).to have_css('.book-box', count: 3)

      els = all(:css, '.book-box')
      expect(els[0].find('.content-title a')).to have_content('レンタル本３')
      expect(els[0].find('.status')).to have_content('返却遅延中')
      expect(els[0].find('.returned_at')).to have_content(expired_collection.returned_at)
      expect(els[1].find('.content-title a')).to have_content('レンタル本２')
      expect(els[1].find('.status')).to have_content('貸出中')
      expect(els[1].find('.returned_at')).to have_content(rented_collection.returned_at)
      expect(els[2].find('.content-title a')).to have_content('レンタル本１')
      expect(els[2].find('.status')).to have_content('予約可')
      expect(els[2].find('.status')).not_to have_content('返却日')
    end

    scenario '本を借りるボタンをクリックするとログインページに遷移する' do
      visit lends_path

      click_link '本を借りる'

      expect(page).to have_css('h2', text: 'ログイン')
    end
  end

  context 'ログイン後' do
    include_context 'ユーザーとしてログインしている'

    background do
      visit lends_path
    end

    scenario '本を借りるボタンをクリックすると貸出ページに遷移する' do
      click_link '本を借りる'

      expect(page).to have_css('h2', text: '本の貸出')
    end

    scenario '本を借りれる' do
      click_link '本を借りる'

      expect(page).to have_css('h3', text: 'レンタル本１')

      click_button 'この本を借りる'

      expect(page).to have_css('h2', text: 'レンタル本１')
      expect(page).to have_css('.alert-success', text: "本の貸出が完了しました。返却日は#{reservable_collection.returned_at}です。")
    end
  end
end
