class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  belongs_to :coupon, optional: true
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: [:cancelled, :in_progress, :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def subtotal
    invoice_items.sum("unit_price * quantity")
  end

  def coupon_discount(total)
    return total unless coupon && coupon.status == "active"
    
    discount = if coupon.value_type == "$"
                  coupon.value
                else coupon.value_type == "%"
                  total * (coupon.value / 100.0)
                end
    [total - discount, 0].max
  end
  
  def grand_total_revenue
    coupon_discount(subtotal)
  end


  def redeem_coupon
    transactions.each do |transaction|
      if coupon && coupon.status == "active" && transaction.result == "success" &&  coupon.redemptions < 5
        coupon.increment!(:redemptions)
      end
    end
  end
  

end
