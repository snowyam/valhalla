User.create!(first_name:  "Valhalla",
             last_name:   "Project",
             email:       "valhalla@example.org",
             password:              "foobar",
             password_confirmation: "foobar",
             confirmed_at: Time.zone.now)

61.times do |n|
  first_name = Faker::Name.first_name
  last_name  = Faker::Name.last_name
  email = "example-#{n+1}@example.org"
  password = "password"
  User.create!(first_name: first_name,
               last_name:  last_name,
               email:      email,
               password:              password,
               password_confirmation: password,
               confirmed_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
20.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.posts.create!(content: content) }
end

# Friendships
users = User.all
user  = users.first
added_friends = users[2..50]
friend_requests = users[3..40]
added_friends.each { |friended| user.add_friend(friended) }
friend_requests.each { |friender| friender.add_friend(user) }

# Likes
users = User.order(:created_at).take(5)
posts = Post.order(:created_at).take(80)
posts.each do |post|
  users.each { |user| post.likes.create!(user_id: user.id)}
end

# Comments
users = User.order(:created_at).take(3)
posts = Post.order(:created_at).take(80)
posts.each do |post|
  content = Faker::Lorem.sentence(5)
  users.each { |user| post.comments.create!(user_id: user.id,
                                            content: content) }
end

# Profiles
users = User.order(:created_at).take(3)
users.each do |user|
  bio = Faker::Lorem.sentence
  user.profile.update(bio: bio)
end
