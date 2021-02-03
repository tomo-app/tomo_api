# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: "logan@email.com", username: "LoganRools", password: BCrypt::Password.create("1234"))
User.create(email: "leah@email.com", username: "LeahDrools", password: BCrypt::Password.create("1234"))
User.create(email: "david@email.com", username: "DavidSmells", password: BCrypt::Password.create("1234"))

japanese = Language.new(name: 'Japanese')
english = Language.new(name: 'English')

topic_1 = Topic.create(description: 'hobbies')
TopicTranslation.create(topic: topic_1, language: english, translation: 'What are your hobbies?')
TopicTranslation.create(topic: topic_1, language: japanese, translation: '趣味は何ですか。')

topic_2 = Topic.create(description: 'favorite food')
TopicTranslation.create(topic: topic_2, language: english, translation: 'What is your favorite food?')
TopicTranslation.create(topic: topic_2, language: japanese, translation: '一番好きな食べ物は何ですか。')

topic_3 = Topic.create(description: 'recent movie')
TopicTranslation.create(topic: topic_3, language: english, translation: "What's a recent movie that you've watched?")
TopicTranslation.create(topic: topic_3, language: japanese, translation: '最近見た映画は何ですか。')

topic_4 = Topic.create(description: 'sports')
TopicTranslation.create(topic: topic_4, language: english, translation: 'Do you play any sports?')
TopicTranslation.create(topic: topic_4, language: japanese, translation: 'スポーツをしますか。')

topic_5 = Topic.create(description: 'languages')
TopicTranslation.create(topic: topic_5, language: english, translation: 'Can you speak any other languages?')
TopicTranslation.create(topic: topic_5, language: japanese, translation: '他の言語を話せますか。')

topic_6 = Topic.create(description: 'favorite holiday')
TopicTranslation.create(topic: topic_6, language: english, translation: "What's your favorite holiday?")
TopicTranslation.create(topic: topic_6, language: japanese, translation: '一番好きな休日は何ですか。')