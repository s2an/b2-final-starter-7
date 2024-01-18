class SetCouponsRedemptionsDefaultToZero < ActiveRecord::Migration[7.0]
  def change
    change_column_default :coupons, :redemptions, from: nil, to: 0
  end
end
