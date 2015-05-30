#to do list: -make arrays to hold notification text

puts "Welcome to watergame"

@current_year = 2015
@your_water = 0
@num_of_cities = 0 
@num_of_farms = 0
@num_of_reservoirs = 0
@farm_usage = 0
@city_usage = 0
@water_generated = 0
@holding_capacity = 0
@groundwater = 0
@waste_level = 0
@agriculture = 0
@industry = 0
@aqueducts = false
game_over = nil

def user_input
	if @aqueducts == false
    	puts "What shall we build ([C]ity, [F]arm, [R]eservoir)?"
    	input = gets.chomp.upcase
    	case
        	when input == "R"
        	build_reservoir
        	when input == "F"
        	build_farm
        	when input == "C"
        	build_city
        	when input == "QUIT"
        	game_over = true
        	else
        	input_error
    	end
    else
    	puts "What shall we build ([C]ity, [F]arm, [R]eservoir, [A]queduct)?"
    	input = gets.chomp.upcase
    	case
        	when input == "R"
        	build_reservoir
        	when input == "F"
        	build_farm
        	when input == "C"
        	build_city
        	when input == "A" 
        	build_aqueduct
        	when input == "QUIT"
        	game_over = true
        	else
        	input_error
    	end
    end
end

def input_error
    puts "Invalid selection."
    user_input
end

def build_reservoir
	@num_of_reservoirs += 1
    @holding_capacity += 10
        puts "You built a new reservoir. Water storage capacity increased."
    end_turn
end

def build_farm
	@num_of_farms += 1
    @agriculture += 10
    @farm_usage += 5
    puts "You built a new farm. May your fields never lie fallow."

    end_turn
end

def build_city
	@num_of_cities += 1
    @industry += 10
    @city_usage += 2
    puts "You built a new city. You built a new city on rock and roll."
    end_turn
end

def build_aqueduct
	@waste_level -= 10
	@water_generated += 10
	puts "You built an aqueduct. Your water is flowing like gravy."
	end_turn
end

def water_shortage
	@industry -= 5
	@agriculture -= 5
	puts "You don't have enough water! Your citizens are thirsty."
	
end

def calc_rainfall
    rainfall = rand(41)
    if rainfall < 10
        puts "A drought! #{rainfall} inches fell in #{@current_year}."
        elsif rainfall > 34
        puts "Heavy rains! #{rainfall} inches fell in #{@current_year}."
        else
        puts "#{rainfall} inches of rain came down in #{@current_year}."
    end
    @groundwater += rainfall - @holding_capacity
    if rainfall >= @holding_capacity
		amount_stored_this_year = @holding_capacity - @your_water
    	@your_water += amount_stored_this_year
    else
    	@your_water += rainfall
    end
end

def calc_advancements
	if @industry >= 100
		@aqueducts = true
		puts "Your cities have become models of industry. You may now build [A]queducts."
	end
end

def calc_water_usage
	usage = @farm_usage + @city_usage
	if usage > @your_water
		water_shortage
	end
end

def end_turn
    calc_rainfall
    calc_advancements
    calc_water_usage
    @current_year += 1
end


until game_over == true
	
puts "The year is now #{@current_year}. Your stats:"
puts "You have #{@your_water} gallons of water available."
puts "Farmers are using #{@farm_usage} gallons."
puts "Cities are using #{@city_usage} gallons."
puts "Current waste is #{@waste_level} gallons per year."

	user_input
	
end