require "faker"
require_relative "scraper"

puts "cleaning the DB..."
Log.destroy_all
CacheSpecy.destroy_all
Cache.destroy_all
Species.destroy_all
User.destroy_all
puts "DB is clean."

# puts "=== making 6 users ==="
# # puts "making 6 users..."

# User.create(email: "a@a.a", password: "secret", username: "anna")
# User.create(email: "b@b.b", password: "secret", username: "bob")

# 4.times do User.create!(
#   email: Faker::Internet.email,
#   password: "secret",
#   username: Faker::Twitter.screen_name
# )
# end

# puts ">>> 6 users made."

# # Photos from assets for seeding
# PHOTOS = [
#   "chanterelle.jpg",
#   "damson_plum.jpg",
#   "hazelnut.jpg",
#   "juniper.jpg",
#   "raspberries.jpg",
#   "stinging_nettle.jpg",
#   "strawberries.jpg",
#   "sumac.jpg",
#   "walnut.jpg"
# ]

GENERIC_TITLES = [
  "I absolutely love finding treasures growing from the ground",
  "what a wonderful adventure I had that day",
  "could not have asked for a better haul",
  "couldn't find what I was looking for; found somethiing even better!",
  "these were delicious",
  "looks like a brain lol",
  "is this past its prime?",
  "epic haul from an honest day's worth of foraging",
  "this stuff was growing in my backyard!",
  "we brought some to the neighbours :)"
]


# # Seeding species

# species_names = [
#   "Apricot Jelly", "Artist's Conk", "Bear's Head Tooth", "Birch Polypore",
#   "Black Trumpet", "Brown Birch Bolete", "Chaga", "Chanterelles", "Chicken Fat Mushroom",
#   "Chicken of the Woods", "Comb Tooth Fungus", "Common Morel", "Dark Stalked Bolete",
#   "Delicious Lactarius", "Dryad's Saddle", "Elm Oyster", "Alfalfa","Alsike Clover",
#   "American Spikenard", "Angelica", "Arctic Raspberry", "Asian Mustard", "Ball Mustard",
#   "Bearberry", "Beggarticks", "Bilberry", "Bitter Dock", "Bladder Campion", "Blue Vervain",
#   "Bluebead", "Borage", "Bracted Orache", "Broadleaf Plantain", "Bugleweed", "Bull Thistle",
#   "Bunchberry", "Burdock", "Canada Lousewort", "Canada Thistle", "Canadian White Violet",
#   "Canyon Grape", "Catnip", "Catsear", "Chamomile", "Chickweed", "Chicory", "Cleavers",
#   "Cloudberry", "Coltsfoot", "Common Agrimony", "Common Reed", "Common Sow Thistle",
#   "Common Yarrow", "Corn Mint", "Creeping Charlie", "Crimson Clover", "Arrowhead", "Cattail",
#   "Coontail", "Eurasian Watermilfoil", "Flowering Rush", "Pickerelweed", "Sea Lungwort",
#   "Sea Plantain", "Sea Sandwort", "Water Lotus", "Water Mint", "Water Plantain", "Watercress",
#   "White Water Lily", "Yellow Water Lily", "Adam's Needle", "Autumn Olive", "Baobab", "Black Chokeberry",
#   "Black Raspberry", "Common Barberry", "Common Blueberry", "Common Chokecherry", "Common Hawthorn",
#   "Common Juniper", "Eastern Redbud", "Eastern White Cedar", "Eastern White Pine", "Elderberry",
#   "Ginkgo", "Highbush Cranberry", "Calendula", "Cornflower", "Fuchsia", "Hibiscus", "Hollyhock",
#   "Lavender", "Marigold", "Nasturtium", "Snapdragon"
# ]

# puts "making #{species_names.length} species"

# species_names.each do |item|
#   @species = species_scraper(item)
#   Species.create!(
#     name: @species[:name],
#     overview: @species[:overview],
#     features: @species[:features],
#     edible: @species[:edible],
#     sporeprint: @species[:sporeprint],
#     habitat: @species[:habitat],
#     gills: @species[:gills],
#     leaves: @species[:leaves],
#     flowers: @species[:flowers],
#     fruit: @species[:fruit],
#     photos: @species[:photos]
#   )
#   puts "made #{item} a species"
# end

# puts "#{species_names.length} species created"

# puts "making 40 caches..."

# # Seeding caches in Montreal

# 40.times do Cache.create!(
#   user: User.all.sample,
#   longitude: [Faker::Number.within(range: -73.83053621933163..-73.56830061735444),
#               Faker::Number.within(range: -73.56708451801268..-73.36224401489754)].sample,
#   latitude: Faker::Number.within(range: 45.4372900644492..45.6280127081368),
#   description: Faker::Lorem.paragraphs(number: 1),
#   found_on: Faker::Date.between(from: 5.days.ago, to: Date.today),
#   seed_photo: PHOTOS.sample,
#   title: GENERIC_TITLES.sample
#   )
# end

# # Avoiding the river

# # lat=45.416762732009886&lng=-73.78362440103011 # awful
# # lat=45.42563154754981&lng=-73.53996688931123 # bad
# # lat=45.45067330399482&lng=-73.50865667352087 # very bad
# # 45.563128244421165, -73.5049835667227 still quite bad

# Cache.all.each do |cache|
#   if  cache.longitude == -73.5086566735 && cache.latitude == 45.450673304 ||
#       cache.longitude == -73.539966889 && cache.longitude == 45.4256315475 ||
#       cache.longitude == -73.783624401 && cache.longitude == 45.4167627320 ||
#       cache.longitude == -73.783624401 && cache.longitude == 45.5631282444
#     cache.destroy
#   end
# end

# puts "~40 caches created."


# # Seeding Logs

# puts "making 300 logs..."

# 300.times do Log.create!(
#   content: Faker::Lorem.paragraphs(number: 1),
#   created_on: Faker::Date.between(from: 5.days.ago, to: Date.today),
#   user_id: User.all.sample.id,
#   cache_id: Cache.all.sample,
#   seed_photo: PHOTOS.sample,
#   title: GENERIC_TITLES.sample
# )
# end

# puts "300 logs created."

# # Seeding Cache_Species, aka CacheSpecy

# puts "Assigning Species to all caches and creating CacheSpecies"

# Cache.all.each do |cache|
#   CacheSpecy.create(cache: cache, species: Species.all.sample)
# end

# puts "Caches now all have a species assigned"

# # Seeding Favorites

# puts "favoriting caches and species..."

# 2.times { User.first.favorite(Species.all.sample) }
# 3.times { User.first.favorite(Cache.all.sample) }

# puts "a@a.a has favorited #{User.first.favorites_by_type('Species').length} species"
# puts "and #{User.first.favorites_by_type('Cache').length} caches."

# 2.times { User.second.favorite(Species.all.sample) }
# 3.times { User.second.favorite(Cache.all.sample) }

# puts "b@b.b has favorited #{User.second.favorites_by_type('Species').length} species"
# puts "and #{User.second.favorites_by_type('Cache').length} caches."

# puts "distributing 12 additional favorites randomly..."

# 12.times { User.all.sample.favorite(Species.all.sample) }

# puts "12 additional favorites seeded."

# ===

# Making very specific seeds for demo

# Users will stay the same

puts "        "
puts "making 6 users..."
# puts "making 6 users..."

User.create(email: "a@a.a", password: "secret", username: "anna")
User.create(email: "b@b.b", password: "secret", username: "bob")

4.times do User.create!(
  email: Faker::Internet.email,
  password: "secret",
  username: Faker::Twitter.screen_name
)
end

puts ">>> 6 users made."

# Seeding species, on which all things depend

puts "         "
puts "seeding species..."

# the specific species and order in which they appear in species_names is
# integral to the matching of cache and species photos.

species_names = [
  "Brown Birch Bolete", "Chanterelles",
  "Chicken of the Woods"]

#   ["Common Morel", "Beggarticks",
#   "Bracted Orache", "Catnip", "Chamomile",
#   "Common Reed", "Common Yarrow",
#   "Common Juniper", "Eastern Redbud",
#   "Canyon Grape", "Elm Oyster"
# ]

def create_species(identifier)
  @identifier = species_scraper(identifier)
  species = Species.create!(
    name: @identifier[:name],
    overview: @identifier[:overview],
    features: @identifier[:features],
    edible: @identifier[:edible],
    sporeprint: @identifier[:sporeprint],
    habitat: @identifier[:habitat],
    gills: @identifier[:gills],
    leaves: @identifier[:leaves],
    flowers: @identifier[:flowers],
    fruit: @identifier[:fruit],
    photos: @identifier[:photos]
  )
  puts "made #{identifier} a species"
  return species
end

species_instances = species_names.map do |identifier|
  create_species(identifier)
end

# puts ">>>first @species photo: #{@species_instances.first.photos.first}"
puts ">>> #{species_instances.length} species created."

puts "          "
puts "seeding caches"

# Seeding caches, with appropriate photos

PHOTOS = [
  "brownbirchbolete.jpg",
  "chanterelle.jpg",
  "chickenofthewoods.jpg",
  "morel.jpg",
  "beggarticks.jpg",
  "bractedorache.jpeg",
  "catnip.jpg",
  "chamomile.jpeg",
  "commonreed.jpg",
  "commonyarrow.jpeg",
  "juniper.jpg",
  "easternredbud.jpg",
  "canyongrape.jpg",
  "elmoyster.jpg"
]

def create_caches(times)
  counter = 0
  caches = []
  times.times do
    cache = Cache.create!(
      user: User.all.sample,
      longitude: [Faker::Number.within(range: -73.83053621933163..-73.56830061735444),
                  Faker::Number.within(range: -73.56708451801268..-73.36224401489754)].sample,
      latitude: Faker::Number.within(range: 45.4372900644492..45.6280127081368),
      description: Faker::Lorem.paragraphs(number: 1), # this should not be lorem ipsum
      found_on: Faker::Date.between(from: 5.days.ago, to: Date.today),
      seed_photo: PHOTOS[counter],
      title: GENERIC_TITLES.sample
    )
    counter += 1
    caches << cache
  end
  return caches
end

cache_instances = create_caches(3)

# puts ">>>first @cache photo: #{cache_instances.first.seed_photo}"
puts ">>> #{cache_instances.length} caches created."

# Seeding CacheSpecies

puts "         "
puts "Assigning Species to all caches and creating CacheSpecies"

def create_cachespecy
  counter = 0
  Cache.all.each do |cache|
    CacheSpecy.create(cache: cache, species: Species.all[counter])
    counter += 1
  end
end

puts "Caches now all have a corresponding species assigned"

# Seeding logs, with appropriate photos
# unfortunately these are the same pics as caches, will diversify if we have time

puts "         "
puts "making 100 logs..."

100.times do
  log = Log.new(
    content: Faker::Lorem.paragraphs(number: 1), # this should not be lorem
    created_on: Faker::Date.between(from: 5.days.ago, to: Date.today),
    user_id: User.all.sample.id,
    cache_id: Cache.all.sample.id,
    title: GENERIC_TITLES.sample
  )
  log.seed_photo = Cache.find_by(id: log.cache_id).seed_photo
  log.save!
end

puts "100 logs created."

# Seeding favorites

puts "        "
puts "favoriting caches and species..."

2.times { User.first.favorite(Species.all.sample) }
3.times { User.first.favorite(Cache.all.sample) }

puts "a@a.a has favorited #{User.first.favorites_by_type('Species').length} species"
puts "and #{User.first.favorites_by_type('Cache').length} caches."

2.times { User.second.favorite(Species.all.sample) }
3.times { User.second.favorite(Cache.all.sample) }

puts "b@b.b has favorited #{User.second.favorites_by_type('Species').length} species"
puts "and #{User.second.favorites_by_type('Cache').length} caches."

puts "distributing 12 additional favorites randomly..."

12.times { User.all.sample.favorite(Species.all.sample) }

puts "12 additional favorites seeded."

puts "             "
puts "
                        .-'~~~-.
                      .'o  oOOOo`.
                      :~~~-.oOo   o`.
  GO TEAM foragr !    `. \ ~-.  oOOo.
                        `.; / ~.  OO:
                        .'  ;-- `.o.'
                      ,'  ; ~~--'~
                      ;  ;
_______\|/__________\\;_\\//___\|/________"
