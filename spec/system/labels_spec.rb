require 'rails_helper'
  RSpec.describe 'ラベル管理機能', type: :system do
    describe '登録機能' do
      let!(:user) { FactoryBot.create(:user) }
      let!(:first_label) { FactoryBot.build(:label, user: user) }
      let!(:second_label) { FactoryBot.build(:second_label, user: user) }
      before do
        visit labels_path
      end
      context 'ラベルを登録した場合' do
        it '登録したラベルが表示される' do
          expect(page).not_to have_content 'aaa'
        end
      end
    end
    describe '一覧表示機能' do
      context '一覧画面に遷移した場合' do
        it '登録済みのラベル一覧が表示される' do
          expect(page).not_to have_content 'aaa'
          expect(page).not_to have_content 'bbb'
        end
      end
    end
  end
