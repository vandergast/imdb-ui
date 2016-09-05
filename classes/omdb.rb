require 'rest-client'
require 'json'

class Omdb
	def search_titles
		print "Enter the name of a movie: "
		title = gets.chomp
		uri = 'http://www.omdbapi.com/?'
		params = {params: {s: title, page: 1}}
		response = JSON.parse(RestClient.get(uri, params).body)		
		puts "Showing movies with title carrying '#{title}'".colorize(:light_blue)
		return response['Search']
		rescue
			ep "NO INTERNET CONNECTION"
			reponse = "abort"
	end
	def search_by_year
		print "Enter the name of a movie: "
		title = gets.chomp
		print "\nEnter the year of the movie: "
		year = gets.chomp
		uri = 'http://www.omdbapi.com/?'
		params = {params: {s: title, y: year}}
		response = JSON.parse(RestClient.get(uri, params).body)		
		puts "Showing movies with title '#{title}' & year '#{year}'".colorize(:light_blue)
		return response['Search']
	end
	def get_details
		puts "Enter the movie imdb ID: "
		target = gets.chomp
		uri = 'http://www.omdbapi.com/?'
		params = {params: {i: target, plot: "full", tomatoes: true}}
		movie = JSON.parse(RestClient.get(uri, params).body)
	end
	def pick_details(id)
		uri = 'http://www.omdbapi.com/?'
		params = {params: {i: id}}
		movie = JSON.parse(RestClient.get(uri, params).body)
	end
end


