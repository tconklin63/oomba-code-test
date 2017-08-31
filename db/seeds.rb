# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
100.times do
  User.create(name: Faker::Name.name, email: Faker::Internet.email)
end

20.times do
  team = Team.create(name: Faker::Team.creature.titleize, description: Faker::Lorem.sentence)
  5.times do
    rand_user = User.all.limit(1).offset(rand(User.count)).first
    team.users << rand_user if !team.users.include?(rand_user)
  end
end