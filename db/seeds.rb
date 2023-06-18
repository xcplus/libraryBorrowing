# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


books = [
  {
    title: "如何阅读一本书",
    inventory: 2,
    borrow_price: 3,
    total_items: 2
  },
  {
    title: "学会提问",
    inventory: 6,
    borrow_price: 5,
    total_items: 6
  },
  {
    title: "思考，快与慢",
    inventory: 8,
    borrow_price: 6,
    total_items: 8
  }
]
Book.create!(books)
