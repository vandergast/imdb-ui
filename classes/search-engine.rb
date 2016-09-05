require_relative './archiver'
require_relative './omdb'
require_relative '../core_exts/printers'

class Engine

	attr_accessor :archive

	def initialize
		dp "Creating Search Engine"
		@archive = Archiver.new
	end

	def show_movies(order)
		paginator = 0
		movie_count = 1
		movies = @archive.movies[order]
		movies.each do |movies|
			puts "#{movies["Title"]} " + "- #{movies["Year"]}"
			puts "#{(Omdb.new.pick_details(movies["imdbID"]))["Plot"]}".italic
			puts "#{movies["imdbID"]}".colorize(:yellow)
			puts "-"*20
			if movie_count % 3 == 0
				paginator += 1
				answer = read_menu(paginator)
				break if answer == "q"
				if answer == "d"
					movie_details
					gets
					break
				end
				system("clear")
			end
			movie_count += 1
		end
		rescue
			ep "There is no movie with that name in the database"
	end

	def movie_title
		@archive.movies[:by_titles] = Omdb.new.search_titles
	end

	def movie_year
		@archive.movies[:by_year] = Omdb.new.search_by_year
	end

	def details
		@archive.movies[:details] = Omdb.new.get_details
	end

  private
	def movie_details
		movie = details
		system("clear")
		puts "#{movie['Title']}"
		puts "released on #{movie['Released']}".colorize(:blue)
		puts "runtime: #{movie['Runtime']}\n".colorize(:blue)
		puts "#{movie['Genre']}"
		puts "Directed by: #{movie['Director']}"
		puts "Written by: #{movie['Writer']}\n"
		puts "Actors: ".colorize(:red) + "#{movie['Actors']}"
		puts "Plot: ".colorize(:magenta) + "#{movie['Plot']}"
		puts "Language: ".colorize(:green) + "#{movie['Language']}"
		puts "Country: ".colorize(:light_blue) + "#{movie['Country']}"
		puts "Awards: ".colorize(:yellow) + "#{movie['Awards']}"
		puts "Tomatoes: ".light_red + "#{movie["tomatoRating"]}"
		puts "Metascore: ".light_yellow + "#{movie["Metascore"]}"
	end	

  def read_menu(paginator)
    puts "(page #{paginator})\n"
    puts "press q to go back to menu".colorize(:light_red)
    puts "press d to see movie details".colorize(:light_yellow)
    puts "press anything else to see next movies".colorize(:light_blue)
    puts ">>".colorize(:light_blue)
    answer = input.downcase
  end
end