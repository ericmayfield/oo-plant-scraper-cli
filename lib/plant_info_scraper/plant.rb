class PlantScraper::Plant
    attr_accessor :name, :light, :zones, :height, :type, :summary

    @@all = []

    def initialize(name) #, light, zones, height, type, summary)
        @name = name
        # @light = light
        # @zones = Range.new
        # @height = height
        # @type = type
        # @summary = summary
        @@all << self
    end

    def self.all
        @@all
    end
end