class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :invoices

  def redemption_count
    invoices.count
  end
end
