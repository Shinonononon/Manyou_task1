require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  describe '登録機能' do
    let!(:task) { FactoryBot.create(:task) }
    # beforeメソッドで、動作を共通化
    before do
      # タスク一覧画面に遷移
      visit tasks_path
    end
    context 'タスクを登録した場合' do
      it '登録したタスクが表示される' do
        expect(page).to have_content '企画書を作成する。'
      end
    end
  end

  describe '一覧表示機能' do
    # let!で複数テストでのテストデータの共有
    let!(:task1) { FactoryBot.create(:task, created_at: 3.days.ago) }
    let!(:task2) { FactoryBot.create(:second_task, created_at: 2.days.ago) }
    let!(:task3) { FactoryBot.create(:third_task, created_at: 1.day.ago) }
    # beforeメソッドで、動作を共通化
    before do
      # タスク一覧画面に遷移
      visit tasks_path
    end

    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が作成日時の降順で表示される' do
        task_lists = all('tbody tr .task-title').map(&:text)
        expect(task_lists).to eq [task3.title, task2.title, task1.title]
      end
    end

    context '新たにタスクを作成した場合' do
      it '新しいタスクが一番上に表示される' do
        task_lists = all('tbody tr .task-title').map(&:text)
        first_task_title = task_lists.first
        expect(first_task_title).to eq task3.title
      end
    end

    describe 'ソート機能' do
      context '「終了期限」というリンクをクリックした場合' do
        it "終了期限昇順に並び替えられたタスク一覧が表示される" do
          visit tasks_path(sort: 'deadline_on')
          task_lists = all('tbody tr .task-title').map(&:text)
          expect(task_lists).to eq [task3.title, task2.title, task1.title]
          # allメソッドを使って複数のテストデータの並び順を確認する
        end
      end
      context '「優先度」というリンクをクリックした場合' do
        it "優先度の高い順に並び替えられたタスク一覧が表示される" do
          visit tasks_path(sort: 'priority')
          task_lists = all('tbody tr .task-title').map(&:text)
          expect(task_lists).to eq [task2.title, task1.title, task3.title]
          # allメソッドを使って複数のテストデータの並び順を確認する
        end
      end
    end
    describe '検索機能' do
      context 'タイトルであいまい検索をした場合' do
        it "検索ワードを含むタスクのみ表示される" do
          fill_in 'search[title]', with: '作成'
          click_button '検索'
          # toとnot_toのマッチャを使って表示されるものとされないものの両方を確認する
          expect(page).to have_content '書類作成'
          expect(page).not_to have_content 'メール送信'
          expect(page).not_to have_content '会議室予約'
        end
      end
      context 'ステータスで検索した場合' do
        it "検索したステータスに一致するタスクのみ表示される" do
          select '未着手' , from: 'search[status]'
          click_button '検索'
          # toとnot_toのマッチャを使って表示されるものとされないものの両方を確認する
          expect(page).to have_content '書類作成'
          expect(page).not_to have_content 'メール送信'
          expect(page).not_to have_content '会議室予約'
        end
      end
      context 'タイトルとステータスで検索した場合' do
        it "検索ワードをタイトルに含み、かつステータスに一致するタスクのみ表示される" do
          fill_in 'search[title]', with: '送信'
          select '着手中' , from: 'search[status]'
          click_button '検索'
          # toとnot_toのマッチャを使って表示されるものとされないものの両方を確認する
          expect(page).not_to have_content '書類作成'
          expect(page).to have_content 'メール送信'
          expect(page).not_to have_content '会議室予約'
        end
      end
    end
  end

  describe '詳細表示機能' do
    let!(:task) { FactoryBot.create(:task) }
    # beforeメソッドで、動作を共通化
    before do
      # タスク一覧画面に遷移
      visit task_path(task)
    end
    context '任意のタスク詳細画面に遷移した場合' do
      it 'そのタスクの内容が表示される' do
        # 詳細画面にタスクの内容が表示されているかどうか
        expect(page).to have_content '書類作成'
      end
    end
  end
end
