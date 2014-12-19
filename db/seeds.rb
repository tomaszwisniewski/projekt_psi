# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

State.destroy_all
Category.destroy_all

state1 = State.create(name: "Alabama")
state2 = State.create(name: "New York")
state3 = State.create(name: "Oregano")
state4 = State.create(name: "Calafiornia")
state5 = State.create(name: "Chickago")

puts "STATES CREATED"

category1 = Category.create(name: "Photography")
category2 = Category.create(name: "Cars")
category3 = Category.create(name: "Mobiles")
category4 = Category.create(name: "Hobby")
category5 = Category.create(name: "Clothes")

puts "CATEGORIES CREATED"



