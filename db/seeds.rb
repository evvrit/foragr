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
PHOTOS = [
  "chanterelle.jpg",
  "damson_plum.jpg",
  "hazelnut.jpg",
  "juniper.jpg",
  "raspberries.jpg",
  "stinging_nettle.jpg",
  "strawberries.jpg",
  "sumac.jpg",
  "walnut.jpg"
]

GENERIC_TITLES = [
  "I absolutely love finding treasures growing from the ground",
  "what a wonderful adventure I had that day",
  "could not have asked for a better haul",
  "couldn't find what I was looking for; found somethiing even better!",
  "dangerous!! not because they're poisonous but because they're delicious"
]

puts "making 40 caches..."

# Getting Montreal bounds

# latitude: 45.450305095784344 (south limit)
# 45.382223818544965 (lower south limit)
# 45.6280127081368 (north limit)
# longitude: -73.36224401489754 (east limit)
# -73.83053621933163 (west limit)

40.times do Cache.create(
  user: User.all.sample,
  longitude: [Faker::Number.within(range: -73.83053621933163..-73.56830061735444),
              Faker::Number.within(range: -73.56708451801268..-73.36224401489754)].sample,
  latitude: Faker::Number.within(range: 45.4372900644492..45.6280127081368),
  description: Faker::Lorem.paragraphs(number: 1),
  found_on: Faker::Date.between(from: 5.days.ago, to: Date.today),
  seed_photo: PHOTOS.sample,
  title: GENERIC_TITLES.sample
  )
end

# Avoiding the river

# lat=45.416762732009886&lng=-73.78362440103011 # awful
# lat=45.42563154754981&lng=-73.53996688931123 # bad
# lat=45.45067330399482&lng=-73.50865667352087 # very bad
# 45.563128244421165, -73.5049835667227 still quite bad

Cache.all.each do |cache|
  if  cache.longitude == -73.5086566735 && cache.latitude == 45.450673304 ||
      cache.longitude == -73.539966889 && cache.longitude == 45.4256315475 ||
      cache.longitude == -73.783624401 && cache.longitude == 45.4167627320 ||
      cache.longitude == -73.783624401 && cache.longitude == 45.5631282444
    cache.destroy
  end
end

puts "~40 caches created."

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
  title: GENERIC_TITLES.sample
)
end

puts "10 logs created."
