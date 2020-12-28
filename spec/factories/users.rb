FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    username { Faker::Superhero.unique.descriptor }
    password { 'password' }
    password_confirmation { 'password' }

    trait :with_availabilities do
      after(:create) do |user|
        create_list(:availability, 3, user: user)
      end
    end
  end
end
