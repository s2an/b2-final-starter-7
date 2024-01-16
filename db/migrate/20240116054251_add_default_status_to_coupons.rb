class AddDefaultStatusToCoupons < ActiveRecord::Migration[7.0]
  def change
    change_column_default :coupons, :status, from: nil, to: "inactive"
  end
end
