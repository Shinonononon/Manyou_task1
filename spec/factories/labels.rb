FactoryBot.define do
  factory :label do
    name { "aaa" }
  end

  factory :second_label, class: Label do
    name { "bbb" }
  end
end
