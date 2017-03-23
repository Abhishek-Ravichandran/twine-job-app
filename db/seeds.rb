User.create!(name:  "Admin User",
             email: "admin@jobs.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

75.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@jobs.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
               
end

75.times do |n|
    title = Faker::Name.title
    description = Faker::Lorem.sentences(5).join ' '
    Job.create!(title: title,
                description: description)
end