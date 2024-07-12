require 'faker'

User.destroy_all

User.create!(first_name: 'Example', last_name: 'User', email: 'example@example.com', password: 'password123!')

users = []

50.times do |i|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  user = {
    first_name:,
    last_name:,
    email: Faker::Internet.email(name: "#{first_name} #{last_name}"),
    encrypted_password: 'password123!'
  }
  users << user
end

User.insert_all!(users)
