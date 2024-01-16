class CouponsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @coupons = @merchant.coupons
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = Coupon.new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = @merchant.coupons.create!(coupon_params)
    redirect_to merchant_coupons_path(@merchant)
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = @merchant.coupons.find(params[:id])
  end

  def edit

  end

  def update 
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = @merchant.coupons.find(params[:id])
    if @coupon.update(coupon_params)
      redirect_to merchant_coupon_path(@merchant, @coupon)
    else
      redirect_to edit_merchant_coupon_path(@merchant, @coupon)
    end
  end

  private

  def coupon_params
    params.require(:coupon).permit(:name, :unique_code, :value, :value_type, :status)
  end
end