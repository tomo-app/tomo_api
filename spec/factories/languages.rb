FactoryBot.define do
  factory :language do
    name { Faker::ProgrammingLanguage.name }

    trait :with_user_languages do
      after(:create) do |language|
        create(:userlanguage, language: language)
      end
    end
  end
end
