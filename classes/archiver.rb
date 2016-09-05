class Archiver
	attr_accessor :movies
	def initialize
		@movies = {
			by_titles: [],
			by_year: [],
			details: {}
		}
	end
end