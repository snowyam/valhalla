User.create!(first_name:  "Valhalla",
             last_name:   "Project",
             email:       "valhalla@example.com",
             password:              "foobar",
             password_confirmation: "foobar",
             confirmed_at: Time.zone.now)

User.create!(first_name:  "Odin",
             last_name:   "Project",
             email:       "odin@example.com",
             password:              "foobar",
             password_confirmation: "foobar",
             confirmed_at: Time.zone.now)

5.times do |n|
  first_name = Faker::Name.first_name
  last_name  = Faker::Name.last_name
  email = "example-#{n+2}@example.com"
  password = "password"
  User.create!(first_name: first_name,
               last_name:  last_name,
               email:      email,
               password:              password,
               password_confirmation: password,
               confirmed_at: Time.zone.now)
end

user = User.first
user.posts.create!(content: "Welcome to Valhalla!")
user.posts.create!(content: "Comment on some posts! Like some stuff!")

user = User.find_by_id(2)
user.posts.create!(content: "Welcome to Valhalla!")
user.posts.create!(content: ":)")


users = User.where(id: 3..6)
10.times do
  users.each do |user|
    content = Faker::Hipster.paragraph
    user.posts.create!(content: content)
  end
end

# Friendships
users = User.all
user  = users.first
added_friends = users[1..5]
friend_requests = users[1..5]
added_friends.each { |friended| user.add_friend(friended) }
friend_requests.each { |friender| friender.add_friend(user) }

# Likes
users = User.order(:created_at).take(6)
posts = Post.all
posts.each do |post|
  users.each { |user| post.likes.create!(user_id: user.id)}
end

# Comments
users = User.order(:created_at).take(3)
posts = Post.order(:created_at).take(25)
posts.each do |post|
  users.each do |user|
    content = Faker::Pokemon.name
    post.comments.create!(user_id: user.id, content: content)
  end
end

# Profiles
db = User.all
users = db[2..6]
users.each do |user|
  bio = Faker::ChuckNorris.fact
  birthplace = Faker::Space.nebula
  currentplace = Faker::Space.star_cluster
  education = Faker::Educator.university
  occupation = Faker::Space.agency_abv
  user.profile.update(bio: bio, birthplace: birthplace,
                      currentplace: currentplace,
                      education: education,
                      occupation: occupation)
end

user = User.find_by_id(1)
user.profile.update(bio: "I'm a Rails app!",
                    birthplace: "The Internet",
                    currentplace: "Heroku, AWS",
                    occupation: "Social Network")

user = User.find_by_id(2)
user.profile.update(bio: "The Allfather",
                    birthplace: "Asgard",
                    currentplace: "Valhalla",
                    education: "Aesir",
                    occupation: "Norse God of Programming")