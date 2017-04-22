User.create!(name:  "小俣友寛",
             email: "ajadj4@gmail.com",
             password:              "tomohiro17",
             password_confirmation: "tomohiro17",
             admin: true)

5.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end
