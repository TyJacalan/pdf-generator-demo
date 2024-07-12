require 'faker'

# Create users

User.destroy_all

User.create!(first_name: 'Example', last_name: 'User', email: 'example@example.com', password: 'password123!')

users = []

50.times do
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

p "Created #{User.count} users"

# Create lists

List.destroy_all

lists_data = [
  { name: 'Users', data: [
      { name: 'John Doe', position: 'Developer' },
      { name: 'Alice Smith', position: 'Manager' }
    ]
  },
  { name: 'Customers', data: [
      { name: 'Bob Johnson', company: 'ABC Inc.' },
      { name: 'Emily Brown', company: 'XYZ Corp.' }
    ]
  },
  { name: 'Products', data: [
      { name: 'Product A', price: '$100' },
      { name: 'Product B', price: '$150' }
    ]
  },
  { name: 'Tasks', data: [
      { title: 'Task 1', description: 'Complete assignment by Friday' },
      { title: 'Task 2', description: 'Prepare presentation for Monday' }
    ]
  },
  { name: 'Contacts', data: [
      { name: 'Sam Green', email: 'sam@example.com', phone: '+1234567890' },
      { name: 'Lucy White', email: 'lucy@example.com', phone: '+9876543210' }
    ]
  }
]

List.insert_all(lists_data)

puts 'Lists seeded successfully.'
