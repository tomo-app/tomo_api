FactoryBot.define do
  factory :topic do
    description { Faker::Hipster.sentence }
    created_at { Faker::Time.between(from: DateTime.now - 365, to: DateTime.now) }
    updated_at { Faker::Time.between(from: DateTime.now - 365, to: DateTime.now) }
  end
end