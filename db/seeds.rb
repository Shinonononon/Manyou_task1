# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 50.times do |i|
#   Task.create!(title: "Task#{i+1}" , content: "test#{i+1}")
# end


5.times do |i|
  Task.create!(title: "first_task" , content: "test#{i+1}", deadline_on: Date.new(2022, 2, 18), priority: :medium, status: :NotStarted )
end
5.times do |i|
  Task.create!(title: "second_task" , content: "test#{i+1}", deadline_on: Date.new(2022, 2, 17), priority: :high, status: :InProgress )
end
5.times do |i|
  Task.create!(title: "third_task" , content: "test#{i+1}", deadline_on: Date.new(2022, 2, 16), priority: :low, status: :Completed )
end
