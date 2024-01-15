class RenameCouponsActiveToStatus < ActiveRecord::Migration[7.0]
  def change
    rename_column :coupons, :active, :status
  end
end
