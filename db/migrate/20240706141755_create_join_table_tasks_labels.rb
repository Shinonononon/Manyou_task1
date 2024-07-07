class CreateJoinTableTasksLabels < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks_labels do |t|
      t.references :task, null: false, foreign_key: true
      t.references :label, null: false, foreign_key: true

      t.timestamps
    end

    add_index :tasks_labels, [:task_id, :label_id], unique: true
    add_index :tasks_labels, [:label_id, :task_id], unique: true
  end
end
