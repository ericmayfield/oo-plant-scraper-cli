class PlantScraper::Scraper 

    BASE_URL = "https://www.bhg.com/bin/plants/"

    def self.scrape_by_zip(zip)
        doc = Nokogiri::HTML(open(BASE_URL+"?zipZone=#{zip}")).css(".singleResult")
        doc.each { |plant| PlantScraper::Plant.new(plant.css(".plantInfo .name h5 a").text)}
    end

end