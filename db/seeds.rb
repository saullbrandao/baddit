require 'faker'

# Create users
30.times do |i|
  User.create(
    email: Faker::Internet.email,
    username: Faker::Internet.username,
    password: 'password',
    password_confirmation: 'password'
  )
end

users = User.all

# Create communities
['rails', 'ruby', 'webdev', 'fullstack', 'programming'].each do |name|
  Community.create(name: name, owner_id: users.sample.id )
end

communities = Community.all

# Create posts and comments
communities.each do |community|
  3.times do |i|
    community.posts.create(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph_by_chars(number: 500), upvotes: rand(0..50), downvotes: rand(0..50), user: users.sample)
    community.posts.last.comments.create(body: Faker::Lorem.sentence, user: users.sample)
  end
end

User.create(
  email: 'test@test',
  username: 'test',
  password: '123123',
  password_confirmation: '123123'
)