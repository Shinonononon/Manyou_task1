FactoryBot.define do
  factory :task do
    title { '書類作成' }
    content { '企画書を作成する。' }
    deadline_on { Date.new(2022, 2, 18) }
    priority { :medium } # enumの値に合わせてシンボルで指定する
    status { :NotStarted } # enumの値に合わせてシンボルで指定する
  end

  factory :second_task, class: Task do
    title { 'メール送信' }
    content { '顧客へ営業のメールを送る。' }
    deadline_on { Date.new(2022, 2, 17) }
    priority { :high } # enumの値に合わせてシンボルで指定する
    status { :InProgress } # enumの値に合わせてシンボルで指定する
  end

  factory :third_task, class: Task do
    title { '会議室予約' }
    content { '明日の会議のための部屋を予約する。' }
    deadline_on { Date.new(2022, 2, 16) }
    priority { :low } # enumの値に合わせてシンボルで指定する
    status { :Completed } # enumの値に合わせてシンボルで指定する
  end
end
