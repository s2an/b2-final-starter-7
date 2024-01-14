require "rails_helper"

RSpec.describe "coupon index" do
  before :each do
    @merchant = create(:merchant)
    @coupon = create(:coupon, merchant: @merchant)
    @customer = create(:customer)
    @invoice = create(:invoice, customer: @customer, coupon: @coupon)
    @item = create(:item, merchant: @merchant)
    @ii = create(:invoice_item, invoice: @invoice, item: @item)
    @transaction = create(:transaction, invoice: @invoice)
  end

  describe "US2: Merchant Coupon Create" do
      # As a merchant
      # When I visit my coupon index page 
      # I see a link to create a new coupon.
      # When I click that link 
      # I am taken to a new page where I see a form to add a new coupon.
      # When I fill in that form with a name, unique code, an amount, and whether that amount is a percent or a dollar amount
      # And click the Submit button
      # I'm taken back to the coupon index page 
      # And I can see my new coupon listed.

    it "fdsjfsdnuj" do
      visit merchant_coupons_path(@merchant)
      # save_and_open_page
    end
  end
end