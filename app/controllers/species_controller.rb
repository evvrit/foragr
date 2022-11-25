require "open-uri"
require "nokogiri"

class SpeciesController < ApplicationController
  before_action :set_species, only: :show

  def show
    authorize @species
    @plant = scraper_plants
    @fungus = scraper_fungi
    @tree_shrub = scraper_trees_shrubs
    # @photo = scraper_photo
  end

  private

  def set_species
    @species = Species.find(params[:id])
  end

  # Scraping specific elements
  def scraper_name(link)
    url = @base_url + link

    html_file = URI.open(url).read
    file = Nokogiri::HTML(html_file)
    file.search("h1").children.first.text
  end

  def scraper_photo(link)
    url = @base_url + link

    html_file = URI.open(url).read
    file = Nokogiri::HTML(html_file)
    photo_value = file.search("#blog-item-holder img").attribute("src").value
    @base_url + photo_value
  end

  def scraper_overview(link)
    url = @base_url + link

    html_file = URI.open(url).read
    file = Nokogiri::HTML(html_file)
    title = "Overview"
    text = file.search("#ctl00_mainBodyContent_overview").text
    return title, text
  end

  def scraper_edible(link)
    url = @base_url + link

    html_file = URI.open(url).read
    file = Nokogiri::HTML(html_file)
    title = file.search("#ctl00_mainBodyContent_edibleparts h3").text
    text = file.search("#ctl00_mainBodyContent_edibleparts p").text
    return title, text
  end

  def scraper_leaves(link)
    url = @base_url + link

    html_file = URI.open(url).read
    file = Nokogiri::HTML(html_file)
    title = file.search("#ctl00_mainBodyContent_leaves h3").text
    text = file.search("#ctl00_mainBodyContent_leaves p").text
    return title, text
  end

  def scraper_flowers(link)
    url = @base_url + link

    html_file = URI.open(url).read
    file = Nokogiri::HTML(html_file)
    title = file.search("#ctl00_mainBodyContent_flower h3").text
    text = file.search("#ctl00_mainBodyContent_flower p").text
    return title, text
  end

  def scraper_fruit(link)
    url = @base_url + link

    html_file = URI.open(url).read
    file = Nokogiri::HTML(html_file)
    title = file.search("#ctl00_mainBodyContent_fruit h3").text
    text = file.search("#ctl00_mainBodyContent_fruit p").text
    return title, text
  end

  def scraper_habitat(link)
    url = @base_url + link

    html_file = URI.open(url).read
    file = Nokogiri::HTML(html_file)
    title = file.search("#ctl00_mainBodyContent_habitat h3").text
    text = file.search("#ctl00_mainBodyContent_habitat p").text
    return title, text
  end

  def scraper_features(link)
    url = @base_url + link

    html_file = URI.open(url).read
    file = Nokogiri::HTML(html_file)
    title = file.search("#ctl00_mainBodyContent_features h3").text
    text = file.search("#ctl00_mainBodyContent_features p").text
    return title, text
  end

  def scraper_sporeprint(link)
    url = @base_url + link

    html_file = URI.open(url).read
    file = Nokogiri::HTML(html_file)
    title = file.search("#ctl00_mainBodyContent_sporeprint h3").text
    text = file.search("#ctl00_mainBodyContent_sporeprint p").text
    return title, text
  end

  def scraper_gills(link)
    url = @base_url + link

    html_file = URI.open(url).read
    file = Nokogiri::HTML(html_file)
    title = file.search("#ctl00_mainBodyContent_gills h3").text
    text = file.search("#ctl00_mainBodyContent_gills p").text
    return title, text
  end

  # Scraping for the main query
  def scraper_plants
    @base_url = "https://www.ediblewildfood.com"
    url = "https://www.ediblewildfood.com/search-results.aspx?s1=stinging+nettle"
    html_file = URI.open(url).read
    html_doc = Nokogiri::HTML(html_file)
    link = html_doc.search("#ctl00_mainBodyContent_divPlants a").attribute("href").value
    name = scraper_name(link)
    photo = scraper_photo(link)
    overview = scraper_overview(link)
    edible = scraper_edible(link)
    leaves = scraper_leaves(link)
    flowers = scraper_flowers(link)
    fruit = scraper_fruit(link)
    habitat = scraper_habitat(link)
    return name, photo, overview, edible, leaves, flowers, fruit, habitat
  end

  def scraper_fungi
    @base_url = "https://www.ediblewildfood.com"
    url = "https://www.ediblewildfood.com/search-results.aspx?s1=oyster"
    html_file = URI.open(url).read
    html_doc = Nokogiri::HTML(html_file)
    link = html_doc.search("#ctl00_mainBodyContent_divFungi a").attribute("href").value
    name = scraper_name(link)
    photo = scraper_photo(link)
    overview = scraper_overview(link)
    edible = scraper_edible(link)
    features = scraper_features(link)
    sporeprint = scraper_sporeprint(link)
    gills = scraper_gills(link)
    habitat = scraper_habitat(link)
    return name, photo, overview, edible, features, sporeprint, gills, habitat
  end

  def scraper_trees_shrubs
    @base_url = "https://www.ediblewildfood.com"
    url = "https://www.ediblewildfood.com/search-results.aspx?s1=sumac"
    html_file = URI.open(url).read
    html_doc = Nokogiri::HTML(html_file)
    link = html_doc.search("#ctl00_mainBodyContent_divTreesShrubs a").attribute("href").value
    name = scraper_name(link)
    photo = scraper_photo(link)
    overview = scraper_overview(link)
    edible = scraper_edible(link)
    leaves = scraper_leaves(link)
    flowers = scraper_flowers(link)
    fruit = scraper_fruit(link)
    habitat = scraper_habitat(link)
    return name, photo, overview, edible, leaves, flowers, fruit, habitat
  end
end
