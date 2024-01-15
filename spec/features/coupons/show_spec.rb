require "rails_helper"

RSpec.describe "merchant coupon show" do
  before :each do
    @merchant = create(:merchant)
    @coupon = create(:coupon, merchant: @merchant)
    @customer = create(:customer)
    @invoice = create(:invoice, customer: @customer, coupon: @coupon)
    @item = create(:item, merchant: @merchant)
    @ii = create(:invoice_item, invoice: @invoice, item: @item)
    @transaction = create(:transaction, invoice: @invoice)
  end

  describe "US3: Merchant Coupon Show Page" do
    # As a merchant 
    # When I visit a merchant's coupon show page 
    # I see that coupon's name and code 
    # And I see the percent/dollar off value
    # As well as its status (active or inactive)
    # And I see a count of how many times that coupon has been used.
    
    # (Note: "use" of a coupon should be limited to successful transactions.)
    
    it "displays the associated coupons, thier status, and number of times used" do
      visit merchant_coupon_path(@merchant, @coupon)

      expect(current_path).to eq(merchant_coupon_path(@merchant, @coupon))

      expect(page).to have_content(@coupon.name)
      expect(page).to have_content(@coupon.unique_code)
      expect(page).to have_content(@coupon.value)
      expect(page).to have_content(@coupon.value_type)
      expect(page).to have_content(@coupon.status)
      expect(page).to have_content(@coupon.redemptions)    
    end
  end
end