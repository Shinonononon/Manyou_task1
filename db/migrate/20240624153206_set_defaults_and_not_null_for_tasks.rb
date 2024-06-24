class SetDefaultsAndNotNullForTasks < ActiveRecord::Migration[6.1]
  def up
    # 既存のレコードにデフォルト値を設定
    Task.update_all(deadline_on: ActiveRecord::Base.connection.raw_connection.exec("SELECT CURRENT_DATE").first['current_date'], priority: 0, status: 0)

    # デフォルト値とNotNull制約を追加
    change_column_default :tasks, :deadline_on, -> { 'CURRENT_DATE' }
    change_column_default :tasks, :priority, 0
    change_column_default :tasks, :status, 0

    change_column_null :tasks, :deadline_on, false
    change_column_null :tasks, :priority, false
    change_column_null :tasks, :status, false
  end

  def down
    # デフォルト値とNotNull制約を削除
    change_column_null :tasks, :deadline_on, true
    change_column_null :tasks, :priority, true
    change_column_null :tasks, :status, true

    change_column_default :tasks, :deadline_on, nil
    change_column_default :tasks, :priority, nil
    change_column_default :tasks, :status, nil
  end
end
