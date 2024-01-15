class AddRedemptionsToCoupons < ActiveRecord::Migration[7.0]
  def change
    add_column :coupons, :redemptions, :integer
  end
end
