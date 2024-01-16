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
    @coupon = @merchant.coupons.new(coupon_params)
    if @coupon.save
      redirect_to merchant_coupons_path(@merchant)
    else
      render :new
      # add flash
    end
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = @merchant.coupons.find(params[:id])
  end

  def update 
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = @merchant.coupons.find(params[:id])
    if @coupon.update(coupon_params)
      redirect_to merchant_coupon_path(@merchant, @coupon)
    else
      render :edit
    end
  end

  private

  def coupon_params
    params.permit(:name, :unique_code, :value, :value_type, :status)
  end
end