class ChangeCouponsStatusToString < ActiveRecord::Migration[7.0]
  def change
    rename_column :coupons, :status, :string
  end
end
