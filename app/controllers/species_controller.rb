require "open-uri"
require "nokogiri"

class SpeciesController < ApplicationController
  before_action :set_species, only: :show

  def show
    authorize @species
    @species = species_scraper("oyster mushroom")
  end

  def create
    @species = Species.new
    authorize @species
  end

  private

  def set_species
    @species = Species.find(params[:id])
  end

  # Scraping specific elements
  def scraper_name
    html_file = URI.open(@url).read
    file = Nokogiri::HTML(html_file)
    file.search("h1").children.first.text
  end

  def scraper_photos
    html_file = URI.open(@url).read
    file = Nokogiri::HTML(html_file)
    photos = []
    file.search("#blog-item-holder img").each do |element|
      photo_value = element.attribute("src").value
      photos << (@base_url + photo_value)
    end
    return photos.first(3)
  end

  def scraper_overview
    html_file = URI.open(@url).read
    file = Nokogiri::HTML(html_file)
    title = "Overview"
    text = file.search("#ctl00_mainBodyContent_overview").text
    return title, text
  end

  def scraper_edible
    html_file = URI.open(@url).read
    file = Nokogiri::HTML(html_file)
    title = file.search("#ctl00_mainBodyContent_edibleparts h3").text
    text = file.search("#ctl00_mainBodyContent_edibleparts p").text
    return title, text
  end

  def scraper_leaves
    html_file = URI.open(@url).read
    file = Nokogiri::HTML(html_file)
    title = file.search("#ctl00_mainBodyContent_leaves h3").text
    text = file.search("#ctl00_mainBodyContent_leaves p").text
    return title, text
  end

  def scraper_flowers
    html_file = URI.open(@url).read
    file = Nokogiri::HTML(html_file)
    title = file.search("#ctl00_mainBodyContent_flower h3").text
    text = file.search("#ctl00_mainBodyContent_flower p").text
    return title, text
  end

  def scraper_fruit
    html_file = URI.open(@url).read
    file = Nokogiri::HTML(html_file)
    title = file.search("#ctl00_mainBodyContent_fruit h3").text
    text = file.search("#ctl00_mainBodyContent_fruit p").text
    return title, text
  end

  def scraper_habitat
    html_file = URI.open(@url).read
    file = Nokogiri::HTML(html_file)
    title = file.search("#ctl00_mainBodyContent_habitat h3").text
    text = file.search("#ctl00_mainBodyContent_habitat p").text
    return title, text
  end

  def scraper_features
    html_file = URI.open(@url).read
    file = Nokogiri::HTML(html_file)
    title = file.search("#ctl00_mainBodyContent_features h3").text
    text = file.search("#ctl00_mainBodyContent_features p").text
    return title, text
  end

  def scraper_sporeprint
    html_file = URI.open(@url).read
    file = Nokogiri::HTML(html_file)
    title = file.search("#ctl00_mainBodyContent_sporeprint h3").text
    text = file.search("#ctl00_mainBodyContent_sporeprint p").text
    return title, text
  end

  def scraper_gills
    html_file = URI.open(@url).read
    file = Nokogiri::HTML(html_file)
    title = file.search("#ctl00_mainBodyContent_gills h3").text
    text = file.search("#ctl00_mainBodyContent_gills p").text
    return title, text
  end

  # Scraping for the main query

  def species_scraper(query)
    @base_url = "https://www.ediblewildfood.com"
    query.count(" ").times do
      query[" "] = "-"
    end
    @url = "#{@base_url}/#{query}.aspx"
    return {
      name: scraper_name,
      photos: scraper_photos,
      overview: scraper_overview,
      edible: scraper_edible,
      leaves: scraper_leaves,
      flowers: scraper_flowers,
      fruit: scraper_fruit,
      features: scraper_features,
      sporeprint: scraper_sporeprint,
      gills: scraper_gills,
      habitat: scraper_habitat
    }
  end
end
