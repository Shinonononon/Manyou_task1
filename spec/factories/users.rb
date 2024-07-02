FactoryBot.define do
  factory :user do
    name { "ムサシ" }
    email { "musasi@testmail.com" }
    password { "password" }
    admin { true }
  end

  factory :second_user, class: User do
    name { "コジロウ" }
    email { "kojiro@testmail.com" }
    password { "password" }
    admin { false }
  end

  factory :third_user, class: User do
    name { "ニャース" }
    email { "meowth@testmail.com" }
    password { "password" }
    admin { false }
  end
end
