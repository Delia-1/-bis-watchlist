# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'uri'
require 'net/http'

puts "Seeding the database..."
User.destroy_all
Movie.destroy_all
List.destroy_all
Bookmark.destroy_all


puts "Creating users..."
user1 = User.create!(email: "test1@test.com", password: "123456")
user2 = User.create!(email: "test2@test.com", password: "123456")
user3 = User.create!(email: "test3@test.com", password: "123456")


puts "Creating movies..."


base_url = URI.parse("https://tmdb.lewagon.com/movie/top_rated")
response = Net::HTTP.get(base_url)
movies = JSON.parse(response)["results"].first(15)

movies.each do |movie|
  Movie.create!(
    title: movie["title"],
    overview: movie["overview"],
    poster_url: "https://image.tmdb.org/t/p/w500#{movie["poster_path"]}",
    rating: movie["vote_average"],
    user: [user1, user2, user3].sample
  )
end

puts "creatted #{Movie.count} movies"

puts "Creating lists..."
list1 = List.create!(name: "Love", user: user1)
list2 = List.create!(name: "Action", user: user2)

puts "Seed finished!"
