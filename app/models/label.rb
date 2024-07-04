class Label < ApplicationRecord
  has_and_belongs_to_many :tasks,join_table: :tasks_labels
  belongs_to :user
  validates :name, presence: true
end
