class AddCulmunToLabels < ActiveRecord::Migration[6.1]
  def change
    add_column :labels, :user_id, :integer
    add_index :labels, :user_id
  end
end
