class SnsCredential < ApplicationRecord
  belongs_to :user
  validates_presence_of :user_id, :uid, :provider
  validates_uniqueness_of :uid, uniqueness: {:scope => :provider}
end
