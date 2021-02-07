FactoryBot.define do
  factory :language do
    name { Faker::ProgrammingLanguage.unique.name }
  end
end
