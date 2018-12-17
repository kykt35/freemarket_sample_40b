# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# coding: utf-8
require "csv"

#category table initial data
CSV.foreach('db/categories.csv') do |row|
  parent = Category.where(name: row[0], ancestry: nil).first_or_initialize(name: row[0])
  parent.save
  child = parent.children.where(name: row[1]).first_or_initialize(name: row[1])
  child.save
  grandson =child.children.where(name: row[2]).first_or_initialize(name: row[2])
  grandson.save
end

#item_condition table data
item_conditions = %w(新品、未使用 未使用に近い 目立った傷や汚れなし やや傷や汚れあり 傷や汚れあり 全体的に状態が悪い)
item_conditions.each do |condition|
  item_condition = ItemCondition.where(name: condition).first_or_initialize(name: condition)
  item_condition.save
end

#size table data
#服
clothes_size = %w(S M L FREE SIZE XXS以下 XS(SS) 2XL(3L) 3XL(4L) 4XL(5L)以上)
clothes_size.each do |size|
  size = Size.where(name: size).first_or_initialize(name: size)
  size.save
end
#靴
shoes_size = %w(20cm以下 21cm 21.5cm 22.5cm 23cm 23.5cm 24cm 24.5cm 25.5cm 26cm 26.5cm 27cm 27.5cm 28cm 28.5cm 29cm 29.5cm 30cm 30.5cm 31cm以上 27.5cm以上)
shoes_size.each do |size|
  size = Size.where(name: size).first_or_initialize(name: size)
  size.save
end
#子供服 ~95cm
child_size = %w(60cm 70cm 80cm 90cm 95cm 100cm 110cm 120cm 130cm 140cm 150cm 160cm)
child_size.each do |size|
  size = Size.where(name: size).first_or_initialize(name: size)
  size.save
end

#Shippings table
shippings = %w(未定 らくらくメルカリ便 ゆうメール レターパック 普通郵便(定形、定形外) クロネコヤマト ゆうパック クリックポスト ゆうパケット)
shippings.each do |ship|
  shipping = Shipping.where(name: ship).first_or_initialize(name: ship)
  shipping.save
end

#postage_selests table
postage_selests table = %w(着払い(購入者負担) 送料込み(出品者負担))
postage_selests.each do |post|
  postage = Postage_selest.where(name: post).first_or_initialize(name: post)
  postage.save
end




