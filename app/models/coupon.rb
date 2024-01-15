class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :invoices

  def redemptions
    # if a coupon is on an invoice
    # and the invoice has a successful transaction
    # add 1 to redemptions
    # if a coupon has 5 redemtions, do not allow to add to an invoice
  end
end
