class PlantScraper::Scraper 

    BASE_URL = "https://www.bhg.com/bin/plants/"

    def self.scrape_by_zip(zip)
        doc = Nokogiri::HTML(open(BASE_URL+"?zipZone=#{zip}")).css(".singleResult")
        doc.each { |plant| 
            #array to store attributes while scraping
            attributes = []
            name = plant.css(".plantInfo .name h5 a").text
            plant.css(".attributeSection .singleAttribute").each { |attribute| attributes << attribute.css(".value").text.delete("\n").strip.split.join(" ") }
            summary = plant.css(".description p").text.strip
            PlantScraper::Plant.new(name, attributes[0], attributes[1], attributes[2], attributes[3], summary )
        }        
    end

    def self.scrape_zip_with_attributes(zip, sun_entry, height_entry, plant_type_entry)
        attributes = "?zipZone=#{zip}&light=#{sun_entry}&height=#{height_entry}&type=#{plant_type_entry}"

        doc = Nokogiri::HTML(open(BASE_URL+attributes)).css(".singleResult")
        doc.each { |plant| 
            #array to store attributes while scraping
            attributes = []
            name = plant.css(".plantInfo .name h5 a").text
            plant.css(".attributeSection .singleAttribute").each { |attribute| attributes << attribute.css(".value").text.delete("\n").strip.split.join(" ") }
            summary = plant.css(".description p").text.strip
            PlantScraper::Plant.new(name, attributes[0], attributes[1], attributes[2], attributes[3], summary )
        } 
    end

end