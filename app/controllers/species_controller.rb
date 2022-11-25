require "open-uri"
require "nokogiri"

class SpeciesController < ApplicationController
  before_action :set_species, only: :show

  def show
    authorize @species
    @plant = scraper_plants
    @fungus = scraper_fungi
    @tree_shrub = scraper_trees_shrubs
    @photo = scraper_photo
  end

  private

  def set_species
    @species = Species.find(params[:id])
  end

  # Scraping specific elements
  def scraper_name(link)
    url = "https://www.ediblewildfood.com#{link}"

    html_file = URI.open(url).read
    file = Nokogiri::HTML(html_file)
    file.search("h1").children.first.text
  end

  def scraper_photo
    url = "https://www.ediblewildfood.com/search-results.aspx?s1=sumac"

    html_file = URI.open(url).read
    file = Nokogiri::HTML(html_file)
    photo = file.css("img.cycle-slide")
    raise
  end

  def scraper_overview(link)
    url = "https://www.ediblewildfood.com#{link}"

    html_file = URI.open(url).read
    file = Nokogiri::HTML(html_file)
    title = "Overview"
    text = file.search("#ctl00_mainBodyContent_overview").text
    return title, text
  end

  def scraper_edible(link)
    url = "https://www.ediblewildfood.com#{link}"

    html_file = URI.open(url).read
    file = Nokogiri::HTML(html_file)
    title = file.search("#ctl00_mainBodyContent_edibleparts h3").text
    text = file.search("#ctl00_mainBodyContent_edibleparts p").text
    return title, text
  end

  def scraper_leaves(link)
    url = "https://www.ediblewildfood.com#{link}"

    html_file = URI.open(url).read
    file = Nokogiri::HTML(html_file)
    title = file.search("#ctl00_mainBodyContent_leaves h3").text
    text = file.search("#ctl00_mainBodyContent_leaves p").text
    return title, text
  end

  def scraper_flowers(link)
    url = "https://www.ediblewildfood.com#{link}"

    html_file = URI.open(url).read
    file = Nokogiri::HTML(html_file)
    title = file.search("#ctl00_mainBodyContent_flower h3").text
    text = file.search("#ctl00_mainBodyContent_flower p").text
    return title, text
  end

  def scraper_fruit(link)
    url = "https://www.ediblewildfood.com#{link}"

    html_file = URI.open(url).read
    file = Nokogiri::HTML(html_file)
    title = file.search("#ctl00_mainBodyContent_fruit h3").text
    text = file.search("#ctl00_mainBodyContent_fruit p").text
    return title, text
  end

  def scraper_habitat(link)
    url = "https://www.ediblewildfood.com#{link}"

    html_file = URI.open(url).read
    file = Nokogiri::HTML(html_file)
    title = file.search("#ctl00_mainBodyContent_habitat h3").text
    text = file.search("#ctl00_mainBodyContent_habitat p").text
    return title, text
  end

  # Scraping for the main query
  def scraper_plants
    url = "https://www.ediblewildfood.com/search-results.aspx?s1=stinging+nettle"
    html_file = URI.open(url).read
    html_doc = Nokogiri::HTML(html_file)
    html_doc.search("#ctl00_mainBodyContent_divPlants a").text
  end

  def scraper_fungi
    url = "https://www.ediblewildfood.com/search-results.aspx?s1=oyster"
    html_file = URI.open(url).read
    html_doc = Nokogiri::HTML(html_file)
    html_doc.search("#ctl00_mainBodyContent_divFungi a").text
  end

  def scraper_trees_shrubs
    url = "https://www.ediblewildfood.com/search-results.aspx?s1=sumac"
    html_file = URI.open(url).read
    html_doc = Nokogiri::HTML(html_file)
    link = html_doc.search("#ctl00_mainBodyContent_divTreesShrubs a").attribute("href").value
    name = scraper_name(link)
    # photo = scraper_photo(link)
    overview = scraper_overview(link)
    edible = scraper_edible(link)
    leaves = scraper_leaves(link)
    flowers = scraper_flowers(link)
    fruit = scraper_fruit(link)
    habitat = scraper_habitat(link)
    return name, overview, edible, leaves, flowers, fruit, habitat
  end
end
