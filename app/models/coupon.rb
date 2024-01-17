class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :invoices
  has_many :transactions, through: :invoices

  def count_successful_uses
    self.transactions.where(result: "success").count
  end
end
