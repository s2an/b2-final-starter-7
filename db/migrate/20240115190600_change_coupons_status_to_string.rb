class ChangeCouponsStatusToString < ActiveRecord::Migration[7.0]
  def change
    change_column :coupons, :status, :string
  end
end
