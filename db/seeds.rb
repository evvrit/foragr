require "faker"

puts "cleaning the DB..."
Cache.destroy_all
Species.destroy_all
User.destroy_all
puts "DB is clean."

puts "making 6 users..."

User.create(email: "a@a.a", password: "secret")
User.create(email: "b@b.b", password: "secret")

4.times do User.create(
  email: Faker::Internet.email,
  password: "secret"
)
end

puts "6 users made."

puts "making 40 caches..."

PHOTOS = ["chanterelle.jpg",
          "damson_plum.jpg",
          "hazelnut.jpg",
          "juniper.jpg",
          "raspberries.jpg",
          "stinging_nettle.jpg",
          "strawberries.jpg",
          "sumac.jpg",
          "walnut.jpg"
          ]

40.times do Cache.create(
  user: User.all.sample,
  longitude: Faker::Address.longitude,
  latitude: Faker::Address.latitude,
  description: Faker::Lorem.paragraphs(number: 1),
  found_on: Faker::Date.between(from: 5.days.ago, to: Date.today),
  seed_photo: PHOTOS.sample
)
end

puts "40 caches created."
puts "making 100 species..."

100.times do Species.create(
  name: Faker::Food.fruits,
  description: Faker::Lorem.paragraphs(number: 1),
  invasive?: [true, false].sample,
  edible?: [true, false].sample,
  usage: Faker::Lorem.paragraphs(number: 1),
  season: ["spring", "summer", "fall", "winter"].sample,
  photo_url: PHOTOS.sample
)
end

puts "100 species created."
