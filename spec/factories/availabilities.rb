FactoryBot.define do
  factory :availability do
    start_date_time { Faker::Time.between(from: DateTime.new(2021, 1, 1), to: DateTime.new(2022, 12, 31)).to_i }
    end_date_time { Faker::Time.between(from: DateTime.new(2021, 1, 1), to: DateTime.new(2022, 12, 31)).to_i }
    created_at { Faker::Time.between(from: DateTime.new(2021, 1, 1), to: DateTime.new(2022, 12, 31)) }
    updated_at { Faker::Time.between(from: DateTime.new(2021, 1, 1), to: DateTime.new(2022, 12, 31)) }
    association :user
  end
end
