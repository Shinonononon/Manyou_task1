class Task < ApplicationRecord
  enum priority: { low: 0, medium: 1, high: 2 }
  enum status: { NotStarted: 0, InProgress: 1, Completed: 2 }

  validates :title, presence: true
  validates :content, presence: true
  validates :deadline_on, presence: true
  validates :priority, presence: true
  validates :status, presence: true
  # sortスコープ
  scope :sort_deadline_on, -> { order(deadline_on: :asc) }
  scope :sort_priority, -> { order(priority: :desc) }
  # searchスコープ
  scope :search, lambda { |search_params|
    return if search_params.blank?

    title_like(search_params[:title])
      .status_search(search_params[:status])
  }

  scope :title_like, ->(title) { where('title LIKE ?', "%#{title}%") if title.present? }
  scope :status_search, ->(status) { where(status: status) if status.present? }

end
