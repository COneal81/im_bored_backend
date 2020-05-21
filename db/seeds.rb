# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

winter = Category.create(category_name: "Winter")
spring = Category.create(category_name: "Spring")
summer = Category.create(category_name: "Summer")
fall = Category.create(category_name: "Fall")
indoor = Category.create(category_name: "Indoor")
outdoor = Category.create(category_name: "Outdoor")

bike = Activity.create(title: "Ride Bike", description: "Ride your bike", category_id: spring.id)
fish = Activity.create(title: "Go fishing", description: "Have a picnic down by the pond and let the kids fish!", category_id: summer.id)
legos = Activity.create(title: "Play with your legos", description: "Build a house out of legos", category_id: indoor.id)
garden = Activity.create(title: "Tend to the garden", description: "Water the garden", category_id: spring.id)
fire = Activity.create(title: "Firepit", description: "Play a guessing game around the firepit", category_id: fall.id) 