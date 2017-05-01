# User.create!(name:  "小俣友寛",
#              email: "ajadj4@gmail.com",
#              password:              "tomohiro17",
#              password_confirmation: "tomohiro17",
#              admin: true,
#              activated: true,
#              activated_at: Time.zone.now)

# 20.times do |n|
#   name  = Faker::Name.name
#   email = "example-#{n+1}@railstutorial.org"
#   password = "password"
#   User.create!(name:  name,
#                email: email,
#                password:              password,
#                password_confirmation: password,
#                activated: true,
#                activated_at: Time.zone.now)
# end

# users = User.all
# user  = users.first
# following = users[2..21]
# followers = users[3..21]
# following.each { |followed| user.follow(followed) }
# followers.each { |follower| follower.follow(user) }

10.times do |n|
comment          = Faker::Lorem.sentences
amount           = Faker::Number.number(4)
user_id          = n+1
evens, odds = (1..10).partition { |n| n % 2 == 0 }
Propose.create!(comment: comment,
                amount: amount,
                user_id: user_id,
                have_currency_id: evens,
                want_currency_id: odds)
end
