# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# アドミンユーザー作成
admin = User.create!(
  name: 'Admin',
  email: 'admintest@example.com',
  password: 'password',
  password_confirmation: 'password',
  admin: true
)

# 通常ユーザー作成
user = User.create!(
  name: 'User',
  email: 'usertest@example.com',
  password: 'password',
  password_confirmation: 'password',
  admin: false
)

# アドミンタスク
50.times do |i|
  Task.create!(
    title: "Admin Task #{i + 1}",
    content: "admin test #{i + 1}",
    user: admin
  )
end

# ユーザーたすく
50.times do |i|
  Task.create!(
    title: "User Task #{i + 1}",
    content: "user test #{i + 1}",
    user: user
  )
end
