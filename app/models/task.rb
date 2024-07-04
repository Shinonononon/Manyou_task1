class Task < ApplicationRecord
  has_and_belongs_to_many :labels, join_table: :tasks_labels
  belongs_to :user
  enum priority: { low: 0, medium: 1, high: 2 }
  enum status: { NotStarted: 0, InProgress: 1, Completed: 2 }

  validates :title, presence: true
  validates :content, presence: true
  validates :deadline_on, presence: true
  validates :priority, presence: true
  validates :status, presence: true

  scope :sort_deadline_on, -> { order(deadline_on: :asc) }
  scope :sort_priority, -> { order(priority: :desc) }

  scope :search, ->(search_params) {
    return if search_params.blank?

    search_title(search_params[:title])
      .search_status(search_params[:status])
      .search_labels(search_params[:label])
  }

  scope :search_title, ->(title) { where('title LIKE ?', "%#{title}%") if title.present? }
  scope :search_status, ->(status) { where(status: status) if status.present? }
  scope :search_labels, ->(label) { joins(:labels).where(labels: { id: label }) if label.present? }
end
