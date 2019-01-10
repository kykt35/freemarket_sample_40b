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
  parent = Category.where(name: row[0].lstrip  , ancestry: nil).first_or_initialize(name: row[0].lstrip  )
  parent.save
  child = parent.children.where(name: row[1].lstrip  ).first_or_initialize(name: row[1].lstrip  )
  child.save
  grandson =child.children.where(name: row[2].lstrip  ).first_or_initialize(name: row[2].lstrip  )
  grandson.save
end

has_brand_categories = ["レディース", "メンズ", "ベビー・キッズ", "インテリア・住まい・小物", "コスメ・香水・美容", "家電・スマホ・カメラ", "スポーツ・レジャー"]
has_brand_categories.each do |cate|
  parent = Category.find_by(name: cate)
    parent.update(hasBrand: true)
    parent.children.each do |child|
      child.update(hasBrand: true)
      child.children.each do |grand_child|
        grand_child.update(hasBrand: true)
    end
  end
end

#item_condition table data
item_conditions = %w(新品、未使用 未使用に近い 目立った傷や汚れなし やや傷や汚れあり 傷や汚れあり 全体的に状態が悪い)
item_conditions.each do |condition|
  item_condition = ItemCondition.where(text: condition).first_or_initialize(text: condition)
  item_condition.save
end

#size table data
#服
clothes_size = %w(S M L FREE SIZE XXS以下 XS(SS) XL(LL) 2XL(3L) 3XL(4L) 4XL(5L)以上)
clothes_size.each do |size|
  size = Size.where(name: size).first_or_initialize(name: size)
  size.save
end
#靴
shoes_size = %w(20cm以下 20.5cm 21cm 21.5cm 22cm 22.5cm 23cm 23.5cm 24cm 24.5cm 25cm 25.5cm 26cm 26.5cm 27cm 27.5cm 28cm 28.5cm 29cm 29.5cm 30cm 30.5cm 31cm以上 27.5cm以上 23.5cm以下)
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
child_shoes = %w(10.5cm以下 11cm・11.5cm 12cm・12.5cm 13cm・13.5cm 14cm・14.5cm 15cm・15.5cm 16cm・16.5cm 16.5cm以上)
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

# 着払い(購入者負担)
postage = PostageSelect.find_by(text: "着払い(購入者負担)")
shippings = %w(未定 クロネコヤマト ゆうパック ゆうメール)
shippings.each do |s|
  shipping =   Shipping.find_by(text: s)
  ps = PostageSelectsShipping.where(postage_select_id: postage.id,shipping_id: shipping.id).first_or_initialize(postage_select_id: postage.id,shipping_id: shipping.id)
  ps.save
end

# 送料込み(出品者負担)
postage = PostageSelect.find_by(text: "送料込み(出品者負担)")
shippings = %w(未定 らくらくメルカリ便 ゆうメール レターパック 普通郵便(定形、定形外) クロネコヤマト ゆうパック クリックポスト ゆうパケット)
shippings.each do |s|
  shipping =   Shipping.find_by(text: s)
  ps = PostageSelectsShipping.where(postage_select_id: postage.id,shipping_id: shipping.id).first_or_initialize(postage_select_id: postage.id,shipping_id: shipping.id)
  ps.save
end


#レディース　服
lady_cloth_size = %w(XXS以下 XS(SS) S M L XL(LL) 2XL(3L) 3XL(4L) 4XL(5L)以上 FREE SIZE)
clothes = ["トップス", "ジャケット/アウター", "パンツ", "スカート", "ワンピース"]
clothes.each do |cloth|
  category = Category.find_by(name: cloth, ancestry: 1)
  lady_cloth_size.each do |s|
    size = Size.find_by(name: s)
    CategoriesSize.find_or_create_by(category_id: category.id,size_id: size.id)
  end
end

# レディース　靴
lady_shoes_size = %w(20cm以下 20.5cm 21cm 21.5cm 22cm 22.5cm 23cm 23.5cm 24cm 24.5cm 25cm 25.5cm 26cm 26.5cm 27cm 27.5cm以上)
category = Category.find_by(name: "靴", ancestry: 1)
lady_shoes_size.each do |s|
  size = Size.find_by(name: s)
  CategoriesSize.find_or_create_by(category_id: category.id,size_id: size.id)
end


#メンズ　服
men_cloth_size = %w(XXS以下 XS(SS) S M L XL(LL) 2XL(3L) 3XL(4L) 4XL(5L)以上 FREE SIZE)
clothes = ["トップス", "ジャケット/アウター", "パンツ", "スーツ"]
clothes.each do |cloth|
  category = Category.find_by(name: cloth, ancestry: 138)
  men_cloth_size.each do |s|
    size = Size.find_by(name: s)
    CategoriesSize.find_or_create_by(category_id: category.id,size_id: size.id)
  end
end

# メンズ　靴
men_shoes_size = %w(23.5cm以下 24cm 24.5cm 25cm 25.5cm 26cm 26.5cm 27cm 27.5cm 28cm 28.5cm 29cm 29.5cm 30cm 30.5cm 31cm以上)
category = Category.find_by(name: "靴", ancestry: 138)
men_shoes_size.each do |s|
  size = Size.find_by(name: s)
  CategoriesSize.find_or_create_by(category_id: category.id,size_id: size.id)
end


