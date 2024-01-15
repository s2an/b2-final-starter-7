class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :invoices

  def redemption_count
    if invoices.count <= 5
      invoices.count
    end
  end
end
