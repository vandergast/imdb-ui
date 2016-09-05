require_relative '../core_exts/printers'
require_relative ('./search-engine')
require_relative ('./menu')

class IMDB
  attr_accessor :imdb, :menu

	def initialize
		@imdb = Engine.new
		options = [
			"\n\t1.- Search by Title (press 1)".colorize(:light_yellow),
			"\n\t2.- Search by Year (press 2)".colorize(:light_yellow),
			"\n\t3.- Exit (press 3)".colorize(:light_red)
		]
		description = "A movie database searcher"
		app_name = "IMDB Search Engine".upcase.colorize(:green)
		@menu = Menu.new(
			options: options, 
			actions: method(:actions).to_proc, 
			app_name: app_name,
			description: description
			)
	end

	def actions(choice)
		case choice
			when 1
				if !(@imdb.movie_title == "abort")
					@imdb.show_movies(:by_titles)
				end
			when 2
				if !(@imdb.movie_year == "abort")
					@imdb.show_movies(:by_year)
				end
			when 3
				abort("\n\tThank you for stopping by\n\n")
		end 
	end
end		