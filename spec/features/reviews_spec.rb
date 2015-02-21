require 'spec_helper'

feature '読書感想', js: true do
  context '感想一覧ページ' do
    # TODO book、collection、review 周りはまとめる
    let(:user) { create(:user, name: 'kamina') }
    let!(:book) { create(:book, title: '自分の信じる自分を信じろ') }
    let!(:collection) { create(:collection, book_id: book.id, user_id: user.id) }

    background do
      1.upto(7).each do |i|
        create(:review, :review_whatever, title: "素敵な本#{i}")
      end

      create(:review, title: '最高の本', collection_id: collection.id)

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
  end

  context '感想詳細ページ' do
    let(:user) { create(:user, name: 'kamina') }
    let!(:book) { create(:book, title: '自分の信じる自分を信じろ') }
    let!(:collection) { create(:collection, book_id: book.id, user_id: user.id) }
    let!(:review) { create(:review, title: '最高の本です！', content: '熱い気持ちになる最高のアニメ', collection_id: collection.id) }
    let!(:other_user_review) { create(:review, :review_whatever, title: 'おもしろい本') }

    background do
      visit reviews_path
    end

    scenario '詳細ページに遷移して、必要項目が表示されている' do
      expect(page).to have_css('h2', text: '読書感想一覧')

      within '#contents' do
        click_link '最高の本'
      end

      expect(page).to have_css('h2', text: '最高の本')
      expect(page).to have_css('h3', text: '自分の信じる自分を信じろ')
      expect(page).to have_content('kamina')
      expect(page).to have_content('熱い気持ちになる最高のアニメ')
    end
  end

  context '感想投稿ページ' do
    context 'ログインしていない場合' do
      scenario 'マイページの感想ページに遷移するとログイン画面に遷移する' do
        visit mypage_reviews_path

        expect(page).to have_css('h2', text: 'ログイン')
      end
    end

    context 'ログインしている場合' do
      include_context 'ユーザーとしてログインしている'

      let!(:book) { create(:book, title: '自分の信じる自分を信じろ') }
      let!(:collection) { create(:collection, book_id: book.id, user_id: current_user.id) }
      let!(:review) { create(:review, title: '最高の本', collection_id: collection.id) }

      background do
        visit mypage_reviews_path
      end

      scenario '感想を投稿するボタンをクリックすると投稿ページに遷移して感想を書ける' do
        click_link '感想を投稿する'

        expect(page).to have_css('h2', text: '読書感想 投稿')

        select '自分の信じる自分を信じろ', from: 'review_collection_id'
        fill_in 'review[title]', with: 'グレンラガン！'
        fill_in 'review[content]', with: '兄貴最高！'
        fill_in 'review[evaluation]', with: '5'

        click_on '投稿する'

        expect(page).to have_css('.alert-success', text: '感想を投稿しました')
        expect(page).to have_css('h2', text: 'グレンラガン！')
      end

      scenario 'タイトル、本文にバリデーションが適用される' do
        click_link '感想を投稿する'

        click_on '投稿する'

        within '.alert.alert-danger' do
          expect(page).to have_css('ul li', text: 'Titleを入力してください。')
          expect(page).to have_css('ul li', text: 'Contentを入力してください。')
        end

        fill_in 'review[title]', with: '本' * 51

        click_on '投稿する'

        within '.alert.alert-danger' do
          expect(page).to have_css('ul li', text: "Titleは50文字以内で入力してください。")
        end
      end
    end
  end

  context '感想編集ページ' do
    include_context 'ユーザーとしてログインしている'

    let!(:book) { create(:book, title: '自分の信じる自分を信じろ') }
    let!(:collection) { create(:collection, book_id: book.id, user_id: current_user.id) }
    let!(:review) { create(:review, title: 'ログインユーザの感想', content: 'この本は読んだほうがいい！', evaluation: 5, collection_id: collection.id) }

    let!(:other_collection) { create(:collection, :collection_whatever) }
    let!(:other_review) { create(:review, title: '他ユーザの感想', content: '他ユーザの感想だよ', evaluation: 5, collection_id: other_collection.id) }


    background do
      visit mypage_reviews_path
    end

    scenario '編集ページに遷移して、編集できる' do
      expect(page).to have_css('h2', text: '読書感想一覧')

      click_link '編集'

      expect(page).to have_css('h2', text: '読書感想 編集')

      expect(page).to have_content('自分の信じる自分を信じろ')

      expect(find('#review_title').value).to eq 'ログインユーザの感想'
      expect(find('#review_content').value).to eq 'この本は読んだほうがいい！'
      expect(find('#review_evaluation').value).to eq '5'

      fill_in 'review[title]', with: '編集したタイトル'

      click_on '投稿する'

      expect(page).to have_css('h2', text: '編集したタイトル')
      expect(page).to have_css('.alert.alert-success', text: '感想を更新しました')
    end

    scenario '他ユーザーの書いたレビューは編集できない' do
      edit_mypage_review_path(other_review)

      expect(page).to have_css('h2', text: '読書感想一覧')
    end
  end
end
