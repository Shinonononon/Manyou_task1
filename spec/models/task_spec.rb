require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空文字の場合' do
      it 'バリデーションに失敗する' do
        task = Task.new(title: '', content: 'タスクの内容')
        expect(task).not_to be_valid
        #expect(task.errors[:title]).to include("Title can’t be blank")
      end
    end

    context 'タスクの説明が空文字の場合' do
      it 'バリデーションに失敗する' do
        task = Task.new(title: 'タスクのタイトル', content: '')
        expect(task).not_to be_valid
        #expect(task.errors[:content]).to include("Content can’t be blank")
      end
    end

    context 'タスクのタイトルと説明に値が入っている場合' do
      it 'タスクを登録できる' do
        task = Task.new(title: 'タスクのタイトル', content: 'タスクの内容', user: create(:user))
        expect(task).to be_valid
      end
    end
  end


  describe '検索機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:first_task) { FactoryBot.create(:task, title: 'first_task_title', user: user) }
    let!(:second_task) { FactoryBot.create(:second_task, title: "second_task_title", user: user) }
    let!(:third_task) { FactoryBot.create(:third_task, title: "third_task_title", user: user) }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索ワードを含むタスクが絞り込まれる" do
        # タイトルの検索メソッドをseach_titleとしてscopeで定義した場合のコード例
        # scopeを使って定義した検索メソッドに検索ワードを挿入する
        # toとnot_toのマッチャを使って検索されたものとされなかったものの両方を確認する
        # 検索されたテストデータの数を確認する
        expect(Task.search_title('first')).to include(first_task)
        expect(Task.search_title('first')).not_to include(second_task)
        expect(Task.search_title('first')).not_to include(third_task)
        expect(Task.search_title('first').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.search_status(:NotStarted)).to include(first_task)
        expect(Task.search_status(:NotStarted)).not_to include(second_task)
        expect(Task.search_status(:NotStarted)).not_to include(third_task)
        expect(Task.search_status(:NotStarted).count).to eq 1
        # toとnot_toのマッチャを使って検索されたものとされなかったものの両方を確認する
        # 検索されたテストデータの数を確認する
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索ワードをタイトルに含み、かつステータスに完全一致するタスクが絞り込まれる" do
        # toとnot_toのマッチャを使って検索されたものとされなかったものの両方を確認する
        # 検索されたテストデータの数を確認する
        expect(Task.search_title('first').search_status(:NotStarted)).to include(first_task)
        expect(Task.search_title('first').search_status(:NotStarted)).not_to include(second_task)
        expect(Task.search_title('first').search_status(:NotStarted)).not_to include(third_task)
        expect(Task.search_title('first').search_status(:NotStarted).count).to eq 1
      end
    end
  end
end
