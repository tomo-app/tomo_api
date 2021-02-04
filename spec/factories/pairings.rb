require 'rails_helper'

FactoryBot.define do
  factory :pairing do
    date_time { Faker::Time.between(from: DateTime.now - 365, to: DateTime.now + 365) }
    user1_cancelled? { [true, false].sample }
    user2_cancelled? { [true, false].sample }
    association :user1, factory: :user
    association :user2, factory: :user
  end
end
