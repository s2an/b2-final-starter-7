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

    it "adds a new coupon to a merchant" do
      visit merchant_coupons_path(@merchant)
      expect(page).to have_link("Create New Coupon", href: new_merchant_coupon_path(@merchant))
      
      click_link "Create New Coupon"

      expect(current_path).to eq(new_merchant_coupon_path(@merchant))
      fill_in "Name", with: "DealyDeal"
      fill_in "Unique code", with: "123|xyz"
      fill_in "Value", with: 1
      select "%", from: "Value type"
      
      click_button "Create Coupon"
      
      expect(current_path).to eq(merchant_coupons_path(@merchant))
      
      # need to add better targeting here
      expect(page).to have_content("DealyDeal")
      expect(page).to have_content(1)
      expect(page).to have_content("%")
    end

    it "tests SP1: This Merchant already has 5 active coupons" do

    end

    it "tests SP2: Coupon code entered is NOT unique" do
      
    end
  end
end