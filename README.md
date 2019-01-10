
# README

## Usersテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string|null:false|
|avater_image|text||
|introduction|text||
|birthday|date||
|address_id|references|foreign_key: true|
|email|string|null:false, unique: true|
|password|string|null:false, unique:true|
|exhibit|string||


### Association(users)
- has_many :folloing_id, dependent: :destroy
- has_many :follwer_id, dependent: :destroy
- has_many :messages
- has_many :transactions
- has_many :items
- has_many :comments
- has_many :comments_items, through: :comments, source: :items
- has_many :favorites
- has_many :favorited_items, through: :favorites, source: :items
- has_many :address
- has_many :credit_cards, dependent: :destroy
- has_many :points
- has_many :evaluations
- has_many :evaluation_transactions, through: :evaluations, source: :transactions
- has_many :sns_credentials


## Sns_credentialsテーブル

|Column|Type|Options|
|------|----|-------|
|uid|string(255)|not null, indexed => [uid]|
|provider|string(255)|not null, indexed => [provider]|
|refresh token|string(255)||
|access token|string(255)||
|user_id|references|foregin_key: true|

### Association(sns_credentials)
- belongs_to: user

## Relationshipsテーブル

|Column|Type|Options|
|------|----|-------|
|following_id|references|foregin_key: true|
|follower_id|references|foreign_key :true|

### Association(relationships)
- belongs_to :folloing_id, class_name: "User"
- belongs_to :follower_id, class_name: "User"


## Pointsテーブル

|Column|Type|Options|
|------|----|-------|
|amount|integer||
|deadline|date||
|user_id|references|foregin_key :true|

### Association(points)
- belongs_to :user


## Credit_cardsテーブル

|Column|Type|Options|
|------|----|-------|
|number|varchar(20)|null:false, unique:true|
|security_code|integer|null:false|
|user_id|references|foregin_key:true|

### Association(credit_card)
- belongs_to :user


## Addressテーブル

|Column|Type|Options|
|------|----|-------|
|last_name|string|null:false|
|first_name|string|null:false|
|last_name_katakana|string|null:false|
|first_name_katakana|string|null:false|
|postal_code|integer|null:false|
|prefectures_id|references|foregin_key:true|
|cities|string|null:false|
|address|string|null:false|
|building_name|string||
|phone_number|integer||


### Association(addresses)
- belongs_to :users
- belongs_to :prefecture


## Prefecturesテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null:false|


### Association(prefectures)
- has_many :address
- has_many :items


## Itemsテーブル
|Column|Type|Options|
|------|----|-------|
|saler_id|references|null: false,foreign_key: true|
|brand|string||
|category_id|references|null: false,foreign_key: true|
|size_id|references|foreign_key: true|
|item_condition_id|references|null: false,foreign_key: true|
|shipping_id|references|null: false,foreign_key: true|
|postage_select_id|references|null: false,foreign_key: true|
|prefecture|references|null: false,foreign_key: true|
|leadtime|references|null: false,foreign_key: true|
|name|string|null: false|
|description|text|null: false|
|status|integer|null: false|
|price|integer|null: false|

### Association
- has_many :transactions
- belongs_to :user
- belongs_to :category
- belongs_to :size
- belongs_to :item_condition
- belongs_to :shipping
- belongs_to :postage_select
- belongs_to :leadtime
- belongs_to :prefecture
- has_many :item_images, dependent: :destroy
- has_many :evaluations
- has_many :evaluation_transactions, through: :evaluations, source: :users, dependent: :destroy
- has_many :comments
- has_many :comments_items, through: :comments, source: :users, dependent: :destroy
- has_many :favorites
- has_many :favorited_items, through: :favorites, source: :users, dependent: :destroy

## Transactionsテーブル
|Column|Type|Options|
|------|----|-------|
|item_id|references|null: false,foreign_key: true|
|buyer_id|references|null: false,foreign_key: true|
|address_id|references|null: false,foreign_key: true|
|payment_id|references|null: false,foreign_key: true|
|status|integer|null: false|
|sales|integer|null: false|

### Association
- belongs_to :item
- belongs_to :user
- belongs_to :evaluation
- has_many :messages


## Evaluationsテーブル
|Column|Type|Options|
|------|----|-------|
|transaction_id|references|null: false,foreign_key: true|
|user_id|references|null: false,foreign_key: true|
|evaluation|integer|null: false check(evaluation >= 0 and evaluation <= 2)|
|date|date|null: false|

### Association
- belongs_to :user
- belongs_to :transaction


## Messagesテーブル
|Column|Type|Options|
|------|----|-------|
|transaction_id|references|null: false,foreign_key: true|
|user_id|references|null: false,foreign_key: true|
|body|text|null: false|

### Association
- belongs_to :transaction
- belongs_to :user


## favoritesテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|references|null:false|
|item_id|references|null:false|


### Association(prefectures)
- belongs_to :user
- belongs_to :item


## Commentsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|references|null:false, foreign_key:true|
|item_id|references|null:false, foreign_key:true|
|text|text|null:false|


### Association(comments)
- belongs_to :user
- belongs_to :item


## Item_imagesテーブル

|Column|Type|Options|
|------|----|-------|
|item_id|references|null:false, foreign_key:true|
|item_image|text||


### Association(item_images)
- belongs_to :item


## Leadtimesテーブル

|Column|Type|Options|
|------|----|-------|
|text|string|null:false|

### Association(leadtimes)
- has_many :items


## Postage_selectsテーブル

|Column|Type|Options|
|------|----|-------|
|text|string|null:false|

### Association(postage_selects)
- has_many :items
- has_many :postage_selects_shippings, dependent :destroy
- has_many :shippings, through: :postage_selects_shippings

## PostageSelects_Shippingsテーブル

|Column|Type|Options|
|------|----|-------|
|postage_select_id|reference|null:false, foreign_key:true|
|shipping_id|reference|null:false, foreign_key:true|

### Association(Postage_selects_Shippings)
- belongs_to :postage_selects
- belongs_to :shippings

## Shippingsテーブル

|Column|Type|Options|
|------|----|-------|
|text|string|null:false|

### Association(shippongs)
- has_many :items,
- has_many :postage_selects_shippings, dependent :destroy
- has_many :postage_select, through: :postage_selects_shippings

## Item_conditionsテーブル

|Column|Type|Options|
|------|----|-------|
|text|string|null:false|

### Association(item_conditions)
- has_many :items


## Sizesテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null:false|

### Association(sizes)
- has_many :items
- has_many :categories_sizes, dependent :destroy
- has_many :categories, through: :categories_sizes


## Categoriesテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null:false|
|parent_id|references|foregin_key:true|

### Association(categories)
- has_many :items
- has_many :children, class_name: "Category"
- belongs_to :parent, class_name: "Category"
- has_many :categories_sizes, dependent :destroy
- has_many :sizes, through: :categories_sizes


## Categories_Sizesテーブル

|Column|Type|Options|
|------|----|-------|
|category_id|reference|null:false|
|size_id|reference|null:false|

### Association(sizes)
- belongs_to :category
- belongs_to :size

## Brandsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null:false|

### Association(brands)
- has_many :items
- has many :brand_group, through:brands_brandGroup
- has_many :brand_brandGroup

## BrandGroup
|Column|Type|Options|
|------|----|-------|
|name|string|null:false|
- has_many :brands, through:brands_brandGroup
- has_many :brands_brandGroup

## Brand_BrandGroupテーブル

|Column|Type|Options|
|------|----|-------|
|brand_id|references|null:false, foreign_key:true|
|brand_group_id|references|null:false, foreign_key:true|

### Association(brands)
- belongs_to :brand
- belongs_to :brandGroup


