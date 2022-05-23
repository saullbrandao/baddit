require 'faker'

# Create users
30.times do |i|
  User.create!(
    email: Faker::Internet.email,
    username: Faker::Internet.username,
    password: 'password',
    password_confirmation: 'password'
  )
end

users = User.all

# Create communities
['rails', 'ruby', 'webdev', 'fullstack', 'programming'].each do |name|
  Community.create!(name: name, owner_id: users.sample.id )
end

communities = Community.all

# Create posts and comments
communities.each do |community|
  3.times do |i|
    post = community.posts
                    .create!(title: Faker::Lorem.sentence,
                             body: Faker::Lorem.paragraph_by_chars(number: 500), 
                             user: users.sample, 
                             created_at: Faker::Time.between(from: 3.month.ago, to: Time.now))
    
    rand(1..30).times do |i|
      post.comments.create!(body: Faker::Lorem.sentence, user: users.sample, created_at: Faker::Time.between(from: post.created_at, to: Time.now))
      post.votes.create!(user: users[i], vote: [1, -1].sample)
    end
  end
end

User.create!(
  email: 'test@test',
  username: 'test',
  password: '123123',
  password_confirmation: '123123'
)