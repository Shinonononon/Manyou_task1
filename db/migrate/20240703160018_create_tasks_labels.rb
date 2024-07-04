class CreateTasksLabels < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks_labels do |t|
      t.references :task
      t.references :label

      t.timestamps
    end
  end
end
