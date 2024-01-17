class Transaction < ApplicationRecord
  validates_presence_of :invoice_id,
                        :credit_card_number,
                        :result
  enum result: [:failed, :success]

  belongs_to :invoice

  # I did all this, but the other started working: revisit because this is better
  # def approve_transaction
  #   transaction.result = "success"
  #   invoice.status = "completed"
  #     if invoice.coupon
  #       transaction.redeem_coupon
  #     end
  # end

  # Active Record Query!!!!!!!!!
  

  def redeem_coupon
    if invoice.coupon.redemptions < 5
      invoice.coupon.increment!(:redemptions)
    end
  end
end
