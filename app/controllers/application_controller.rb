class ApplicationController < ActionController::Base
  def welcome
    @merchants = Merchant.all
    @merchant = @merchants.first
    @coupons = @merchant.coupons if @merchant
  end
end
