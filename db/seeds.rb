# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

# ダミーユーザーの作成
# seeds.rb

# Create 10 dummy users
10.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = Faker::Internet.email(name: "#{first_name} #{last_name}", separators: '.')
  password = 'password' # or any password you want to set for dummy users

  User.create!(
    first_name: first_name,
    last_name: last_name,
    email: email,
    password: password,
    password_confirmation: password
  )
end


# Create 20 dummy boards for each user
20.times do |n|
  title = Faker::TvShows::AquaTeenHungerForce.character
  body = Faker::Coffee.intensifier
  user = User.find_by(id: 1)
  user = Board.create!(title: title,
                        body: body,
                        user: user)
end




