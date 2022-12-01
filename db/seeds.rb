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
  "What a wonderful adventure I had that day",
  "Could not have asked for a better haul",
  "Couldn't find what I was looking for; found somethiing even better!",
  "These were delicious",
  "We had an epic haul from an honest day's worth of foraging",
  "This stuff was growing in my backyard!",
  "We brought some to the neighbours :)"
]

# # Seeding species

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
puts "making anna, river, plus 12 other users...all with password 'secret'"
# puts "making 6 users..."

anna = User.create(email: "a@a.a", password: "secret", username: "anna")
river = User.create(email: "river@gmail.com", password: "secret", username: "RiverFlows95")

12.times do User.create!(
  email: Faker::Internet.email,
  password: "secret",
  username: Faker::Twitter.screen_name
)
end

puts ">>> 14 users made."

# Seeding species, on which all things depend

puts "         "
puts "seeding species..."

all_species = [
  "Apricot Jelly", "Artist's Conk", "Bear's Head Tooth", "Birch Polypore",
  "Black Trumpet", "Brown Birch Bolete", "Chaga", "Chanterelles", "Chicken Fat Mushroom",
  "Chicken of the Woods", "Comb Tooth Fungus", "Common Morel", "Dark Stalked Bolete",
  "Delicious Lactarius", "Dryad's Saddle", "Elm Oyster", "Alfalfa","Alsike Clover",
  "American Spikenard", "Angelica", "Arctic Raspberry", "Asian Mustard", "Ball Mustard",
  "Bearberry", "Beggarticks", "Bilberry", "Bitter Dock", "Bladder Campion", "Blue Vervain",
  "Bluebead", "Borage", "Bracted Orache", "Broadleaf Plantain", "Bugleweed", "Bull Thistle",
  "Bunchberry", "Burdock", "Canada Lousewort", "Canada Thistle", "Canadian White Violet",
  "Canyon Grape", "Catnip", "Catsear", "Chamomile", "Chickweed", "Chicory", "Cleavers",
  "Cloudberry", "Coltsfoot", "Common Agrimony", "Common Reed", "Common Sow Thistle",
  "Common Yarrow", "Corn Mint", "Creeping Charlie", "Crimson Clover", "Arrowhead", "Cattail",
  "Coontail", "Eurasian Watermilfoil", "Flowering Rush", "Pickerelweed", "Sea Lungwort",
  "Sea Plantain", "Sea Sandwort", "Water Lotus", "Water Mint", "Water Plantain", "Watercress",
  "White Water Lily", "Yellow Water Lily", "Adam's Needle", "Autumn Olive", "Baobab", "Black Chokeberry",
  "Black Raspberry", "Common Barberry", "Common Blueberry", "Common Chokecherry", "Common Hawthorn",
  "Common Juniper", "Eastern Redbud", "Eastern White Cedar", "Eastern White Pine", "Elderberry",
  "Ginkgo", "Highbush Cranberry", "Calendula", "Cornflower", "Fuchsia", "Hibiscus", "Hollyhock",
  "Lavender", "Marigold", "Nasturtium", "Snapdragon"
]

# the specific species and order in which they appear in species_names is
# integral to the matching of cache and species photos.

species_names = [
  "Brown Birch Bolete", "Chanterelles",
  "Chicken of the Woods", "Common Morel", "Beggarticks",
  "Bracted Orache", "Catnip", "Chamomile",
  "Common Reed", "Common Yarrow",
  "Common Juniper", "Eastern Redbud",
  "Canyon Grape", "Elm Oyster"
]

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
puts ">>> #{species_instances.length} species created - to be used in caches."

# making sure we still have all species seeded so the user can choose from a full list

# extra_species = all_species.reject do |s|
#   species_names.include?(s)
# end                                                 # => doesn't work for some reason, only rejects 4

extra_species = [
  "Apricot Jelly", "Artist's Conk", "Bear's Head Tooth", "Birch Polypore",
  "Black Trumpet", "Chaga", "Chicken Fat Mushroom", "Comb Tooth Fungus", "Dark Stalked Bolete",
  "Delicious Lactarius", "Dryad's Saddle", "Alfalfa","Alsike Clover",
  "American Spikenard", "Angelica", "Arctic Raspberry", "Asian Mustard", "Ball Mustard",
  "Bearberry", "Bilberry", "Bitter Dock", "Bladder Campion", "Blue Vervain",
  "Bluebead", "Borage", "Broadleaf Plantain", "Bugleweed", "Bull Thistle",
  "Bunchberry", "Burdock", "Canada Lousewort", "Canada Thistle", "Canadian White Violet",
  "Catsear", "Chickweed", "Chicory", "Cleavers",
  "Cloudberry", "Coltsfoot", "Common Agrimony", "Common Sow Thistle",
  "Corn Mint", "Creeping Charlie", "Crimson Clover", "Arrowhead", "Cattail",
  "Coontail", "Eurasian Watermilfoil", "Flowering Rush", "Pickerelweed", "Sea Lungwort",
  "Sea Plantain", "Sea Sandwort", "Water Lotus", "Water Mint", "Water Plantain", "Watercress",
  "White Water Lily", "Yellow Water Lily", "Adam's Needle", "Autumn Olive", "Baobab", "Black Chokeberry",
  "Black Raspberry", "Common Barberry", "Common Blueberry", "Common Chokecherry", "Common Hawthorn",
  "Eastern White Cedar", "Eastern White Pine", "Elderberry",
  "Ginkgo", "Highbush Cranberry", "Calendula", "Cornflower", "Fuchsia", "Hibiscus", "Hollyhock",
  "Lavender", "Marigold", "Nasturtium", "Snapdragon"
]

puts "all species ************** #{all_species.length}"
puts "extra species ************** #{extra_species.length}"
puts "                "
puts "Making the rest of the species for the dropdown..."

extra_species_instances = extra_species.map do |identifier|
  create_species(identifier)
end

puts ">>> #{extra_species_instances.length} species created - for the dropdown."

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

cache_instances = create_caches(14)

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
puts "making River (river@gmail.com) a log with a picture of her dog..."

# Make logs that don't have lorem ipsum as content

LOGS_CONTENT = ["I'm starting to get the hang of plant identification. The other day we came across stinging nettle and I knew it on sight. Of course I took a closer look before bringing some home to my partner but sure enough we had a pasta dish with it and it tasted quite right. I want to venture into some more uncommon mushrooms but I'm afraid my skills aren't at that level just yet; I'm not trying to wind up in the ER. The good thing is I have all the time in the world and I am enjoying the process of learning. I'm glad I got started.",
"The best part of my day is waking up early to catch the sunrise, stumble on some new plant or mushroom, head down to the water to take in some fresh air and give thanks to the earth for all that she provides. I'm amazed at how much is going on beneath my feet. I feel like a kid again!",
"My cooking game has ACCELERATED since I started foraging. I didn't even know most of this stuff existed, and sure, some of it needs a good amount of butter to go down, but a lot of it is tastier than I expected. Plus it's free, so who can complain. I enjoy the process too, though I think I'm going to need to get some better shoes if I'm going to make this a hobby. I think I will! :D"]

GENERIC_LOG_TITLES = [
  "We almost walked right by this",
  "The first hour is the best hour",
  "Killing it in the kitchen"
]

Log.create!(
  content: LOGS_CONTENT[0],
  created_on: Faker::Date.between(from: 5.days.ago, to: Date.today),
  user_id: river.id,
  cache_id: cache_instances[2].id,
  title: GENERIC_LOG_TITLES[0],
  seed_photo: "dog-woods.jpg"
)
puts "making River (river@gmail.com) a log about getting up early to forage..."

Log.create!(
  content: LOGS_CONTENT[1],
  created_on: Faker::Date.between(from: 5.days.ago, to: Date.today),
  user_id: river.id,
  cache_id: cache_instances[-2].id,
  title: GENERIC_LOG_TITLES[1],
  seed_photo: "couple-mountains.jpg"
)

puts "making River (river@gmail.com) a log about cooking well with foraged mushrooms..."

Log.create!(
  content: LOGS_CONTENT[2],
  created_on: Faker::Date.between(from: 5.days.ago, to: Date.today),
  user_id: river.id,
  cache_id: cache_instances[1].id,
  title: GENERIC_LOG_TITLES[2],
  seed_photo: "mushroom-apps.jpg"
)

puts "making 10 fake logs..."

10.times do
  log = Log.new(
    content: LOGS_CONTENT.sample,
    created_on: Faker::Date.between(from: 5.days.ago, to: Date.today),
    user_id: User.all.sample.id,
    cache_id: Cache.all.sample.id,
    title: GENERIC_TITLES.sample
  )
  log.seed_photo = Cache.find_by(id: log.cache_id).seed_photo
  log.save!
end

puts "10 fake logs created."

# Seeding favorites

puts "        "
puts "favoriting caches and species..."

2.times { User.first.favorite(Species.all.sample) }
3.times { User.first.favorite(Cache.all.sample) }

puts "a@a.a has favorited #{User.first.favorites_by_type('Species').length} species"
puts "and #{User.first.favorites_by_type('Cache').length} caches."

2.times { User.second.favorite(Species.all.sample) }
3.times { User.second.favorite(Cache.all.sample) }

puts "river (river@gmail.com) has favorited #{User.second.favorites_by_type('Species').length} species"
puts "and #{User.second.favorites_by_type('Cache').length} caches."

puts "             "
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
