require 'faker'

['rails', 'ruby', 'webdev', 'fullstack', 'programming'].each do |name|
  Community.create(name: name)
end

Community.all.each do |community|
  (1..3).each do |i|
    community.posts.create(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph_by_chars(number: 500), upvotes: rand(0..50), downvotes: rand(0..50))
    community.posts.last.comments.create(body: Faker::Lorem.sentence)
  end
end
