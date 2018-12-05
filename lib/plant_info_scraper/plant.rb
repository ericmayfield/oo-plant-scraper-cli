class PlantScraper::Plant
    attr_accessor :name, :light, :zones, :height, :type, :summary

    @@all = []

    def initialize(name, light, height, zones, type, summary)
        @name = name
        @light = light
        @height = height
        @zones = zones
        @type = type
        @summary = summary
        # TODO: Breakout scientific name in future @scientific_name = scientific_name
        @@all << self
    end

    def self.all
        @@all
    end

    def self.clear
        @@all.clear
    end
end