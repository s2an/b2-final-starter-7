class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :invoices
  has_many :transactions, through: :invoices

  validates :unique_code, uniqueness: {message: "code must be unique"}

  def count_successful_uses
    self.transactions.where(result: "success").count
  end
end
