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



# it '作成済みのタスク一覧が作成日時の降順で表示される' do
      #   # テストで使用するためのタスクを登録
      #   task1 =FactoryBot.create(:first_task, created_at: 2022-02-18 )
      #   task2 =FactoryBot.create(:second_task, created_at: 2022-02-17 )
      #   task3 =FactoryBot.create(:third_task, created_at: 2022-02-16)
      #   # タスク一覧画面に遷移
      #   visit tasks_path
      #   # タスクの順番が3-2-1の順になっているかどうか。
      #   task_titles = all('.task-title').map(&:text)
      #   expect(task_titles).to eq [task3.title, task2.title, task1.title]
      #   # expectの結果が「真」であれば成功、「偽」であれば失敗としてテスト結果が出力される
      # end

      # it '新しいタスクが一番上に表示される' do
      #   task1 =FactoryBot.create(:first_task, created_at: 3.days.ago )
      #   task2 =FactoryBot.create(:second_task, created_at: 2.days.ago)
      #   task3 =FactoryBot.create(:third_task, created_at: 1.day.ago)
      #   # タスク一覧画面に遷移
      #   visit tasks_path
      #   # 新しいタスク(task3)が一番上になっているかどうか。
      #   task_titles = all('.task-title').map(&:text)
      #   first_task_title = task_titles.first
      #   expect(first_task_title).to eq task3.title
      # end
