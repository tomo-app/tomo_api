FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    username { Faker::Superhero.unique.descriptor }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
