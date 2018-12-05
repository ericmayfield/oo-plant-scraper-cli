class PlantScraper::CLI

    def start
        print "\n\n"
        puts "Welcome to the Unofficial but Amazing Plant Scraper CLI!!!"
        print "This Gem allows the user to search for plants which thrive in your region. Please enter your zip-code to continue: "
        zip = zip_code?

        print "\n\n"
        print "If you would like to filter results by sunlight, height, or plant type enter \'" + "Y".green + "\' or " + "any key to continue.".green + ": "
        if gets.chomp.capitalize == "Y"
            print "\n\n"
            sun_entry = sun_filter
            height_entry = height_filter
            plant_type_entry = plant_type_filter
            PlantScraper::Scraper.scrape_zip_with_attributes(zip, sun_entry, height_entry, plant_type_entry)
        elsif
            PlantScraper::Scraper.scrape_by_zip(zip)
        else
            start
        end
        print "\n\n"
        menu(zip)
        print "\n\n"
    end

    def zip_code?
        zip = gets.chomp
        
        if zip.length < 5 || zip.length > 5 || !/\A\d+\z/.match(zip)
            print "Your Zip Code entry was incorrect. Please re-enter: "
            zip_code?
        else
            puts zip.to_i
            zip
        end
    end

    def menu(zip)
        if PlantScraper::Plant.all.size > 0
            puts "                                   __".green
            puts "                              _   / /|".green
            puts "                             | \\\  \\/_/".green
            puts "                              \\_\\| / __ ".green             
            puts "                                 \\/_/__\\           ".green + ".-=='/~\\'".red
            puts "                          ____,__/__,_____,______)".green + "/   /{~}}}".red
            puts "                          -,------,----,-----,---,".green + "\\'-' {{~}}".red
            puts "                                                   '-==.\\}/".red
            print "\n\n"
            puts "##############################--  PLANTS FOR #{zip}  --##############################"
            #binding.pry
            PlantScraper::Plant.all.each.with_index(1) { |plant, i| puts "#{i}. #{plant.name.strip}"}
            print "\n\n"
            print "Enter the number of the plant to see its details: " #", #or \'" + "N".green + "\' "
            input = gets.chomp 
            
            if input.to_i > PlantScraper::Plant.all.size  
                puts "Entry was incorrect press any key to try again".red
                menu(zip) if gets.chomp
            else
                plant = PlantScraper::Plant.all[input.to_i-1]
                print "\n\n"
                puts "Plant Name: #{plant.name}"
                puts "Light Type(s): #{plant.light}"
                puts "Height Range: #{plant.height}"
                puts "Growth Zones: #{plant.zones}"
                puts "Plant Type(s): #{plant.type}"
                puts "Summary: #{plant.summary}"
                print "\n"
                print "I hope you found this informative. To return to your results enter \'" + "R".green + "\', to start a new search enter \'" + "N".green + "\', or to exit enter \'" + "X".green + ": "
                menu_input = gets.chomp.capitalize

                #Case to Route user
                case menu_input
                when "R"
                    #Takes user back to original plants
                    puts "Now returning you to the plants list for zip-code #{zip}."
                    menu(zip)
                when "N"
                    #Clears PlantScraper::Plant class array @@all and takes user back to new search
                    PlantScraper::Plant.clear
                    start
                when "X"
                    #Ends program
                    exit
                end

                ##  ask for next 20 results
            end
        else 
            puts "You entered an incorrect zip code please enter a new zip code"
            start
        end
    end

    def exit
        puts "Thanks for using The Amazing but Unofficial Plant Scrapper!"
    end

    def sun_filter
        print "For Sunlight, Enter \'" + "A".green + "\' for Any, \'" + "F".green + "\' for Full, \'" + "P".green + "\' for Partial, or \'" + "S".green + "\' for Shade. Only Choose One: "
        sun_entry = gets.chomp.upcase
        #checking that the sun filter is on a single digit and is only of 4 values filterable
        if sun_entry.length > 1 || !(["A", "P", "F", "S"].include?(sun_entry))
            puts "Your Entry was Incorrect Please Re-Enter Sun Type"
            sun_filter
        else
            #Converting the sun filter to a URL appropriate value
            case sun_entry
            when "A"
                sun_entry = ""
            when "F"
                sun_entry = "Sun"
            when "P"
                sun_entry = "Part+Sun"
            when "S"
                sun_entry = "Shade"
            end
        end

        sun_entry
    end

    def height_filter
        print "For Height, Enter \'" + "A".green + "\' for Any, \'" + "XS".green + "\' for less than 6 inches, \'" + "SM".green + "\' for 6 - 12 inches, \'" + "MD".green + "\' for 1 - 3 feet , \'" + "LG".green + "\' for 3 - 8 feet, \'" + "XL".green + "\' for 8 - 20 feet, or \'" + "XXL".green + "\' for over 20 feet. Only choose One: "
        height_entry = gets.chomp.upcase
        #checking that the height filter is an appropriate entry and is only of 7 values filterable
        if height_entry.length > 3 || !(["A", "XS", "SM", "MD", "LG", "XL", "XXL"].include?(height_entry))
            puts height_entry
            puts "Your Entry was Incorrect Please Re-Enter Sun Type"
            height_filter
        else
            #Converting the height filter to a URL appropriate value
            case height_entry
            when "A"
                height_entry = ""
            when "XS"
                height_entry = "0-6"
            when "SM"
                height_entry = "6-12"
            when "MD"
                height_entry = "1-3"
            when "LG"
                height_entry = "3-8"
            when "XL"
                height_entry = "8-20"
            when "XXL"
                height_entry = "20"
            end
        end
        height_entry
    end

    def plant_type_filter
        print "For Plant Type, Enter \'" + "A".green + "\' for Any, \'" + "N".green + "\' for Annuals and \'" + "P".green + "\' for Perenials, only choose one Plant Type: "
        plant_type_entry = gets.chomp.upcase
        #checking that the sun filter is on a single digit and is only of 4 values filterable
        if plant_type_entry.length > 1 || !(["A", "N", "P"].include?(plant_type_entry))
            puts "Your Entry was Incorrect Please Re-Enter Plant Type"
            plant_type_entry
        else
            #Converting the plant-type filter to a URL appropriate value
            case plant_type_entry
            when "A"
                plant_type_entry = ""
            when "N"
                plant_type_entry = "Annual"
            when "P"
                plant_type_entry = "Perennial"
            end
        end

        plant_type_entry
    end

end