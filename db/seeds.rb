require "faker"

puts "cleaning the DB..."
User.destroy_all
Cache.destroy_all
puts "DB is clean."

puts "making 6 users..."

User.create(email: "a@a.a", password: "secret")
User.create(email: "b@b.b", password: "secret")

4.times do User.create(
  email: Faker::Internet.email
  password: "secret"
)

puts "6 users made."

puts "making 40 caches..."

PHOTOS = ["../../app/assets/images/chanterelle.jpg",
          "../../app/assets/images/damson_plum.jpg",
          "../../app/assets/images/hazelnut.jpg",
          "../../app/assets/images/juniper.jpg",
          "../../app/assets/images/raspberries.jpg",
          "../../app/assets/images/stinging_nettle.jpg",
          "../../app/assets/images/strawberries.jpg",
          "../../app/assets/images/sumac.jpg",
          "../../app/assets/images/walnut.jpg"
          ]

40.times do Cache.create(
  longitude: Faker::Number.normal(mean: 50, standard_deviation: 3.5)
  latitude: Faker::Number.normal(mean: 50, standard_deviation: 3.5)
  description: Faker::Lorem.paragraphs(number: 1)
  found_on: Faker::Date.between(from: 5.days.ago, to: Date.today)
  seed_photo: PHOTOS.sample
)

puts "40 caches created."
