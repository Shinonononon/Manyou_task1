require 'rails_helper'

RSpec.describe 'ユーザ管理機能', type: :system do
  describe '登録機能' do
    let!(:first_user) { FactoryBot.build(:user) }
    context 'ユーザを登録した場合' do
      it 'タスク一覧画面に遷移する' do
        visit new_user_path
        fill_in '名前', with: first_user.name
        fill_in 'メールアドレス', with: first_user.email
        fill_in 'パスワード', with: first_user.password
        fill_in 'パスワード（確認）', with: first_user.password
        click_on '登録する'
        expect(page).to have_content 'タスク一覧'
      end
    end
    context 'ログインせずにタスク一覧画面に遷移した場合' do
      it 'ログイン画面に遷移し、「ログインしてください」というメッセージが表示される' do
        visit tasks_path(first_user)
        expect(current_path).to eq new_session_path
        expect(page).to have_content 'ログインしてください'
      end
    end
  end

  describe 'ログイン機能' do
    let!(:first_user) { FactoryBot.create(:user) }
    before do
      # ログインさせるコードを記述
      visit new_session_path
      fill_in 'login_mail',	with: first_user.email
      fill_in 'login_pass', with: first_user.password
      click_on 'create-session'
    end
    context '登録済みのユーザでログインした場合' do
      it 'タスク一覧画面に遷移し、「ログインしました」というメッセージが表示される' do
        expect(current_path).to eq tasks_path
        expect(page).to have_content 'ログインしました'
      end
      it '自分の詳細画面にアクセスできる' do
        visit user_path(first_user)
        expect(current_path).to eq user_path(first_user)
      end
      it '他人の詳細画面にアクセスすると、タスク一覧画面に遷移する' do
        user2 = FactoryBot.create(:second_user)
        visit user_path(user2)
        # expect(current_path).to eq user_path(first_user)
        expect(current_path).to eq tasks_path
      end
      it 'ログアウトするとログイン画面に遷移し、「ログアウトしました」というメッセージが表示される' do
        click_on 'sign-out'
        expect(current_path).to eq new_session_path
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end

  describe '管理者機能' do
    let!(:first_user) { FactoryBot.create(:user) }
    before do
      visit new_session_path
      fill_in 'login_mail',	with: first_user.email
      fill_in 'login_pass', with: first_user.password
      click_on 'create-session'
    end
    context '管理者がログインした場合' do
      it 'ユーザ一覧画面にアクセスできる' do
        visit admin_users_path
        expect(page).to have_content 'ユーザ一覧ページ'
      end
      it '管理者を登録できる' do
        visit new_admin_user_path
        fill_in '名前', with: 'てすと'
        fill_in 'メールアドレス', with: 'test@test.com'
        fill_in 'パスワード', with: 'passss'
        fill_in 'パスワード（確認）', with: 'passss'
        check 'admin_check'
        click_on '登録する'
        expect(page).to have_content 'ユーザを登録しました'
      end
      it 'ユーザ詳細画面にアクセスできる' do
        user2 = FactoryBot.create(:second_user)
        visit admin_user_path(user2)
        expect(current_path).to eq admin_user_path(user2)
      end
      it 'ユーザ編集画面から、自分以外のユーザを編集できる' do
        user3 = FactoryBot.create(:third_user)
        visit edit_admin_user_path(user3)
        fill_in '名前', with: '編集'
        fill_in 'メールアドレス', with: 'edit@test.com'
        fill_in 'パスワード', with: 'editgg'
        fill_in 'パスワード（確認）', with: 'editgg'
        check 'admin_check'
        click_on '更新する'
        expect(page).to have_content 'ユーザを更新しました'
      end
      it 'ユーザを削除できる' do
        user3 = FactoryBot.create(:third_user)
        visit admin_users_path
        sleep(1)
        accept_alert do
          click_link '削除', href: admin_user_path(user3)
        end
        expect(page).to have_content 'ユーザを削除しました'
      end
    end
    context '一般ユーザがユーザ一覧画面にアクセスした場合' do
      before do
        click_on 'ログアウト'
        user3 = FactoryBot.create(:third_user)
        fill_in 'login_mail',	with: user3.email
        fill_in 'login_pass', with: user3.password
        click_on 'create-session'
      end
      it 'タスク一覧画面に遷移し、「管理者以外アクセスできません」というエラーメッセージが表示される' do
        visit admin_users_path
        expect(current_path).to eq tasks_path
        expect(page).to have_content '管理者以外アクセスできません'
      end
    end
  end
end
