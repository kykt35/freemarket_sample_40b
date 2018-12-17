# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "csv"

#category table initial data
CSV.foreach('db/categories.csv') do |row|
  parent =  Category.where(name: row[0],ancestry: nil).first_or_initialize(name: row[0])
  parent.save
  if parent && parent.has_children?
    child = parent.children.where(name: row[1], ancestry: parent.id).first_or_initialize(name: row[1])
    child.save
  else
    child = parent.children.create(name: row[1], ancestry: parent.id)
  end
  if child && child.has_children?
    child.children.create(name: row[2], ancestry: child.id)
  else
    grandson = child.children.where(name: row[2]).first_or_initialize(name: row[2])
    grandson.save
  end
end

