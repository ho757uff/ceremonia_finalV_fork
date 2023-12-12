# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
UserEvent.destroy_all
EventLocation.destroy_all
Location.destroy_all
Event.destroy_all
Role.destroy_all
Image.destroy_all
Album.destroy_all
User.destroy_all

# 10.times do
#     Location.create(place: Faker::Company.department, address: Faker::Address.city, privacy_status: 1)
# end


# Role.create(role_name: 'organizer')
# Role.create(role_name: 'guest')

# Events = []
# 5.times do
#     event = Event.create(date: "28/05/2024", city_name: Faker::Address.city, title: Faker::Superhero.power, program: Faker::Sport.summer_olympics_sport)
#     Events << event
# end


# 5.times do
#     Album.create(title: Faker::Color.name, description: Faker::Currency.name, event_id: Events.sample.id)
# end