require "faker"

puts "cleaning the DB..."
Log.destroy_all
Cache.destroy_all
Species.destroy_all
User.destroy_all
puts "DB is clean."

# Seeding users
puts "making 6 users..."

User.create(email: "a@a.a", password: "secret")
User.create(email: "b@b.b", password: "secret")

4.times do User.create(
  email: Faker::Internet.email,
  password: "secret"
)
end

puts "6 users made."

# Photos from assets for seeding
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

# Seeding Caches
puts "making 40 caches..."

# latitude: 45.450305095784344 (south limit)
# 45.6280127081368 (north limit)
# longitude: -73.36224401489754 (east limit)
# -73.83053621933163 (west limit)

40.times do Cache.create(
  user: User.all.sample,
  longitude: Faker::Number.within(range: -73.83053621933163..-73.36224401489754),
  latitude: Faker::Number.within(range: 45.450305095784344..45.6280127081368),
  description: Faker::Lorem.paragraphs(number: 1),
  found_on: Faker::Date.between(from: 5.days.ago, to: Date.today),
  seed_photo: PHOTOS.sample
)
end

puts "40 caches created."

# Seeding Species
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

# Seeding Logs
puts "making 10 logs..."

30.times do Log.create(
  content: Faker::Lorem.paragraphs(number: 1),
  created_on: Faker::Date.between(from: 5.days.ago, to: Date.today),
  user_id: User.all.sample.id,
  cache_id: Cache.all.sample.id,
  seed_photo: PHOTOS.sample
)
end

puts "10 logs created."
