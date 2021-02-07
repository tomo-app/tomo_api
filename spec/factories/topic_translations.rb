FactoryBot.define do
  factory :topic_translation do
    association :topic
    association :language
    translation { Faker::Hipster.sentence }
    created_at { Faker::Time.between(from: DateTime.now - 365, to: DateTime.now) }
    updated_at { Faker::Time.between(from: DateTime.now - 365, to: DateTime.now) }
  end
end