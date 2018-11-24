class PlantScraper::Scraper 

    BASE_URL = "https://www.bhg.com/bin/plants/"

    def self.scrape_by_zip(zip)
        doc = Nokogiri::HTML(open(BASE_URL+"?zipZone=#{zip}")).css(".singleResult")
        doc.each { |plant| PlantScraper::Plant.new(plant.css(".plantInfo .name h5 a").text)}
    end

    def self.scrape_zip_with_attributes(zip, sun_entry, height_entry, plant_type_entry)
        attributes = "?zipZone=#{zip}&light=#{sun_entry}&height=#{height_entry}&type=#{plant_type_entry}"

        doc = Nokogiri::HTML(open(BASE_URL+attributes)).css(".singleResult")
        doc.each { |plant| PlantScraper::Plant.new(plant.css(".plantInfo .name h5 a").text)}
    end

end