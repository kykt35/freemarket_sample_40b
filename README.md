
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
|uid|string(255)|not null, indexed => [uid]|
|provider|string(255)|not null, indexed => [provider]|
|refresh token|string(255)||
|access token|string(255)||

### Association(users)
- has_many :folloing_id, dependent: :destroy
- has_many :follwer_id, dependent: :destroy
- has_many :messages
- has_many :transactions
- has_many :items
- has_many :comments_items, through: :comments, source: :items
- has_many :liking_items, through: :likes, source: :items
- has_many :address, dependent: :destroy
- has_many :credit_cards, dependent: :destroy
- has_many :points
- has_many :evaluation_transactions, through: :evaluations, source: :transactions

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
|prefecture_name|string|null:false|


### Association(prefectures)
- has_one :address
- has_many :items


## Itemsテーブル
|Column|Type|Options|
|------|----|-------|
|saler_id|references|null: false,foreign_key: true|
|brand_id|references|foreign_key: true|
|category_id|references|null: false,foreign_key: true|
|size_id|references|null: false,foreign_key: true|
|item_condition_id|references|null: false,foreign_key: true|
|delivery_id|references|null: false,foreign_key: true|
|postage_select_id|references|null: false,foreign_key: true|
|post_prefecture|references|null: false,foreign_key: true|
|leadtime|references|null: false,foreign_key: true|
|name|string|null: false|
|description|text|null: false|
|status|integer|null: false|
|amount|integer|null: false|

### Association
- has_one :transaction
- belongs_to :user
- belongs_to :brand
- belongs_to :category
- belongs_to :size
- belongs_to :item_condition
- belongs_to :delivery
- belongs_to :postage_select
- belongs_to :leadtime
- belongs_to :prefecture
- has_many :item_images, dependent: :destroy
- has_many :evaluation_transactions, through: :evaluations, source: :users, dependent: :destroy
- has_many :comments_items, through: :comments, source: :users, dependent: :destroy
- has_many :liking_items, through: :likes, source: :users, dependent: :destroy

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


## Likesテーブル

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
|item_image|references||


### Association(item_images)
- has_many :items


## Leadtimesテーブル

|Column|Type|Options|
|------|----|-------|
|leadtime|string|null:false|

### Association(leadtimes)
- has_many :items


## Postage_selectsテーブル

|Column|Type|Options|
|------|----|-------|
|postage_select|string|null:false|

### Association(postage_selects)
- has_many :items


## Deliveriesテーブル

|Column|Type|Options|
|------|----|-------|
|deliveries_method|string|null:false|

### Association(deliveries)
- has_many :items


## Item_conditionsテーブル

|Column|Type|Options|
|------|----|-------|
|item_condition|string|null:false|

### Association(item_conditions)
- has_many :items


## Sizesテーブル

|Column|Type|Options|
|------|----|-------|
|size|string|null:false|

### Association(sizes)
- has_many :items


## Categoriesテーブル

|Column|Type|Options|
|------|----|-------|
|category|string|null:false|

### Association(categories)
- has_many :items


## Brandsテーブル

|Column|Type|Options|
|------|----|-------|
|brand|string|null:false|

### Association(brands)
- has_many :items




