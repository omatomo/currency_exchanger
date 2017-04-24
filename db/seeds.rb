User.create!(name:  "小俣友寛",
             email: "ajadj4@gmail.com",
             password:              "tomohiro17",
             password_confirmation: "tomohiro17",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

20.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

users = User.all
user  = users.first
following = users[2..21]
followers = users[3..21]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
