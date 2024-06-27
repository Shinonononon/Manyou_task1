class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true,
format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, confirmation: true
  validates :password,presence: true, length: { minimum: 6 }
  #validates :password_confirmation, presence: true
  before_validation { email.downcase! }
  has_secure_password
end
