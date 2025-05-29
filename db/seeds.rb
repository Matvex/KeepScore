# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user = User.find_or_create_by!(username: "em7575@gmail.com") do |user|
  user.password = "qqw123"
  user.password_confirmation = "qqw123"
end

# Clear existing records
GameSession.delete_all

# Create example records
GameSession.create!(
  user_id: user.id,
  name1: "Alice",
  name2: "Bob",
  name3: "Charlie",
  name4: "Diana",
  total_points1: -20,
  total_points2: -50,
  total_points3: 30,
  total_points4: 40
)

GameSession.create!(
  user_id: user.id,
  name1: "Eve",
  name2: "Frank",
  name3: "Grace",
  name4: "Heidi",
  total_points1: 15,
  total_points2: -25,
  total_points3: -35,
  total_points4: 45
)
