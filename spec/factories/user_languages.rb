FactoryBot.define do
  factory :user_language do
    trait :native do
      fluency_level { 0 }
    end

    trait :target do
      fluency_level { 1 }
    end
  end
end