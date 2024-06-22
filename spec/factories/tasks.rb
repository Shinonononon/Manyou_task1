FactoryBot.define do
  factory :task do
    title { '書類作成' }
    content { '企画書を作成する。' }
  end
  # 作成するテストデータの名前を「second_task」とします
  # 「second_task」のように存在しないクラス名のスネークケースをテストデータ名とする場合、`class`オプションを使ってどのクラスのテストデータを作成するかを明示する必要があります
  factory :second_task, class: Task do
    title { 'メール送信' }
    content { '顧客へ営業のメールを送る。' }
  end
  factory :third_task, class: Task do
    title { '会議室予約' }
    content { '明日の会議のための部屋を予約する。' }
  end
end
