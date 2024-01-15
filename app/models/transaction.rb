class Transaction < ApplicationRecord
  validates_presence_of :invoice_id,
                        :credit_card_number,
                        :result
  enum result: [:failed, :success]

  belongs_to :invoice

  def redeem_coupon
    if result == :success && invoice.coupon
    invoice.coupons.redeemed +1
    end
  end
end
