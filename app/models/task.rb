class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :deadline_on, presence: true
  validates :priority, presence: true
  validates :status, presence: true

  enum priority: { low: 0, midium: 1, high: 2 }
  enum status: { NotStarted: 0, InProgress: 1, Completed: 2 }
end
