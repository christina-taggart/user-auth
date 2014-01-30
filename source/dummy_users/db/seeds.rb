require 'faker'

10.times do
  User.create(email: Faker::Internet.email, password: Faker::Lorem.characters(rand(9..15)))
end