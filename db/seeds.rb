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
  item_condition = ItemCondition.where(text: condition).first_or_initialize(text: condition)
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
  shipping = Shipping.where(text: ship).first_or_initialize(text: ship)
  shipping.save
end

#postage_selests table
postage_selests = ["着払い(購入者負担)", "送料込み(出品者負担)"]
postage_selests.each do |post|
  postage = PostageSelect.where(text: post).first_or_initialize(text: post)
  postage.save
end

#Prefecture table
prefectures = %w(北海道 青森県 岩手県 宮城県 秋田県 山形県 福島県 茨城県
栃木県 群馬県 埼玉県 千葉県 東京都 神奈川県 新潟県 富山県 石川県 福井県
山梨県 長野県 岐阜県 静岡県 愛知県 三重県 滋賀県 京都府 大阪府 兵庫県 奈良県
和歌山県 鳥取県 島根県 岡山県 広島県 山口県 徳島県 香川県 愛媛県 高知県
福岡県 佐賀県 長崎県 熊本県 大分県 宮崎県 鹿児島県 沖縄県)
prefectures.each do |pref|
  prefecture = Prefecture.where(name: pref).first_or_initialize(name: pref)
  prefecture.save
end
 Prefecture.where(id: 99, name: "未定").first_or_initialize(id: 99, name: "未定")

#Leadtime table
["1~2日で発送", "2~3日で発送", "4~7日で発送"].each do |ltime|
  leadtime = Leadtime.where(text: ltime).first_or_initialize(text: ltime)
  leadtime.save
end
