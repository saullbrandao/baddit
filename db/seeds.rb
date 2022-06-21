require 'faker'

# Create users
30.times do |i|
  User.create!(
    email: Faker::Internet.email,
    username: Faker::Internet.username(specifier: 3..20),
    password: 'password',
    password_confirmation: 'password'
  )
end

users = User.all

# Create communities
['rails', 'ruby', 'webdev', 'fullstack', 'programming'].each do |name|
  Community.create!(name: name, owner_id: users.sample.id )
end

# Create posts and comments
communities = Community.all

communities.each do |community|
  10.times do |i|
    user = users.sample
    user.join(community)
    post = community.posts
                    .create!(title: Faker::Lorem.sentence,
                             body: Faker::Lorem.paragraph_by_chars(number: 500), 
                             user: user, 
                             created_at: Faker::Time.between(from: 3.month.ago, to: Time.now))
    
    rand(0..20).times do |i|
      post.comments.create!(body: Faker::Lorem.sentence, user: users.sample, created_at: Faker::Time.between(from: post.created_at, to: Time.now))
      post.votes.create!(user: users[i], vote: [1, -1].sample)
    end
  end
end

Comment.all.each do |comment|
  rand(0..20).times do |i|
    comment.votes.create!(user: users[i], vote: [1, -1].sample)
  end
end

# Test user
User.create!(
  email: 'test@test',
  username: 'test',
  password: '123123',
  password_confirmation: '123123'
)