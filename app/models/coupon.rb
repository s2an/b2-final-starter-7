class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :invoices
  has_many :transactions, through: :invoices

  validate :coupon_limit, on: :create
  validates :value_type, presence: {message: "Value type can't be blank"}
  validates :unique_code, uniqueness: {message: "Code must be unique"}

  def count_successful_uses
    self.transactions.where(result: "success").count
  end

  def coupon_limit
    if merchant && merchant.coupons.where(status: "active").count >= 5
      errors.add(:base, "Merchant has maximum amount of coupons (5)")
    end
  end
end
