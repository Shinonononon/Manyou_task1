require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  describe '登録機能' do
    context 'タスクを登録した場合' do
      it '登録したタスクが表示される' do
        # テストで使用するためのタスクを登録
        FactoryBot.create(:task)
        # タスク一覧画面に遷移
        visit tasks_path
        # visit（遷移）したpage
        expect(page).to have_content '企画書を作成する。'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が作成日時の降順で表示される' do
        # テストで使用するためのタスクを登録
        FactoryBot.create(:task)
        FactoryBot.create(:second_task)
        # タスク一覧画面に遷移
        visit tasks_path
        # second_taskが一番上に表示される。

        # expectの結果が「真」であれば成功、「偽」であれば失敗としてテスト結果が出力される
      end
    end

    context '新たにタスクを作成した場合' do
      it '新しいタスクが一番上に表示される' do
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it 'そのタスクの内容が表示される' do
        # テストで使用するためのタスクを登録
        task = FactoryBot.create(:task)
        # タスク詳細画面に遷移
        visit task_path(task)
        # 詳細画面にタスクの内容が表示されているかどうか
        expect(page).to have_content '書類作成'
      end
    end
  end
end
