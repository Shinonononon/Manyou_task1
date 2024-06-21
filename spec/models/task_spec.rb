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
        task = Task.new(title: 'タスクのタイトル', content: 'タスクの内容')
        expect(task).to be_valid
      end
    end
  end
end
