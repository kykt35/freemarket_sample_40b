class Credit < ApplicationRecord
  belongs_to :user, dependent: :destroy
  validates :number, presence: true, length: { is:16 }
  validates :cvc, presence: true, length: { is:3 }
  validates :month, presence: true
  validates :year, presence: true
  validate :credit_number_length_should_16
  validate :year_should_exist
  validate :month_should_exist

  #オリジナルバリデーション
  def credit_number_length_should_16
    errors.add(:number, "credit number length be 16") unless number.length === 16
  end

  def cvc_length_should_3
    errors.add(:cvc, "cvc length should be 3") unless cvc.length === 3
  end

  def year_should_exist
    errors.add(:year, "year should be exist") unless year.length > 0
  end

  def month_should_exist
    errors.add(:month, "month should be exist") unless month.length > 0
  end

end
