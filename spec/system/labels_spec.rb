require 'rails_helper'
  RSpec.describe 'ラベル管理機能', type: :system do
    let!(:first_user) { FactoryBot.create(:user) }
    let!(:first_label) { FactoryBot.create(:label, user: first_user) }
    let!(:second_label) { FactoryBot.create(:second_label, user: first_user) }
    describe '登録機能' do
      before do
        visit new_session_path
        fill_in 'login_mail',	with: first_user.email
        fill_in 'login_pass', with: first_user.password
        click_on 'create-session'
      end
      context 'ラベルを登録した場合' do
        it '登録したラベルが表示される' do
          visit labels_path
          expect(page).to have_content 'aaa'
        end
      end
    end
    describe '一覧表示機能' do
      before do
        visit new_session_path
        fill_in 'login_mail',	with: first_user.email
        fill_in 'login_pass', with: first_user.password
        click_on 'create-session'
      end
      context '一覧画面に遷移した場合' do
        it '登録済みのラベル一覧が表示される' do
          visit labels_path
          expect(page).to have_content 'aaa'
          expect(page).to have_content 'bbb'
        end
      end
    end
  end
