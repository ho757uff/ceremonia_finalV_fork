# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
User.destroy_all
Location.destroy_all
Event.destroy_all
Role.destroy_all


Users = []
5.times do
    User.create(email: Faker::Internet.unique.email(domain: 'yopmail.com'), password: "123456", first_name: Faker::FunnyName.name, last_name: Faker::FunnyName.name)
end
Users << User



Locations =[]
5.times do
    Location.create(place: Faker::Company.department, address: Faker::Address.city, description: Faker::Lorem.characters(number: 255, min_alpha: 0, min_numeric: 0))
end
Locations << Location


Role.create(role_name: 'organizer')
Role.create(role_name: 'guest')


# EventLocations =[]
# 5.times do
#     EventLocation.create(date: Faker::Time.between(from: DateTime.now, to: '2024-12-31'), location_id: Locations.sample)
# end
# EventLocations << EventLocation