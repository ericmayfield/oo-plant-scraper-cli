class PlantScraper::CLI

    def start
        puts "Welcome to the Unofficial but Amazing Plant Scraper CLI!!!"
        puts "This Gem allows the user to search for plants that grow well in your zip-code. Please enter your zip-code to continue:"
        input = gets.chomp
        puts "Loading..."
        PlantScraper::Scraper.scrape_by_zip(input)
        menu(input)
    end

    def menu(zip)
        puts "##############################--  PLANTS FOR #{zip}  --##############################"
        #binding.pry
        PlantScraper::Plant.all.each.with_index(1) { |plant, i| puts "#{i}. #{plant.name.strip}"}
        input = gets.chomp
    end

end