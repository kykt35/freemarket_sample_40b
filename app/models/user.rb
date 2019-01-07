class User < ApplicationRecord
  validates :nickname, presence: true, length: { maximum: 20 }
  validates_format_of :password, :with => /([0-9].*[a-zA-Z]|[a-zA-Z].*[0-9])/, :message => "は6文字以上の英数混在で入力してください。"
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :credits, dependent: :destroy
  has_many :comments
  has_many :items
  has_many :sns_credentials
  has_many :favorites, dependent: :destroy
  has_many :sales_amounts

  def self.create_from_auth!(auth)
    data = auth['info']
    nickname = auth['info']['name'].split(" ")[0]
    user = User.where(email: data['email']).first_or_create(
      nickname: nickname,
      email: data['email'],
      password: Devise.friendly_token[0,20])
    user_uid = SnsCredential.where(uid: auth['uid'],provider: auth['provider']).first_or_create(
      user: user,
      uid: auth['uid'],
      provider: auth['provider'])
    return user_uid
  end
end
