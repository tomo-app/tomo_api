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