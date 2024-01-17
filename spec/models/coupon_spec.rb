require 'rails_helper'

RSpec.describe Coupon, type: :model do
  describe "relationships" do
    it { should belong_to(:merchant) }
  end

  describe "US3: Merchant Coupon Show Page" do
    # As a merchant 
    # When I visit a merchant's coupon show page 
    # I see that coupon's name and code 
    # And I see the percent/dollar off value
    # As well as its status (active or inactive)
    # And I see a count of how many times that coupon has been used.
    
    # (Note: "use" of a coupon should be limited to successful transactions.)
    
    it "tests count_successful_uses method" do
      merchant = create(:merchant)
      customer = create(:customer)
      coupon = create(:coupon, merchant: merchant)
      item = create(:item, merchant: merchant)
      
      invoice_1 = create(:invoice, customer: customer, coupon: coupon)
      invoice_2 = create(:invoice, customer: customer, coupon: coupon)
      invoice_3 = create(:invoice, customer: customer, coupon: coupon)
      ii = create(:invoice_item, invoice: invoice_1, item: item)
      ii = create(:invoice_item, invoice: invoice_2, item: item)
      ii = create(:invoice_item, invoice: invoice_3, item: item)
      transaction_1 = create(:transaction, invoice: invoice_1, result: "success")
      transaction_2 = create(:transaction, invoice: invoice_2, result: "success")
      transaction_3 = create(:transaction, invoice: invoice_3, result: "success")

      invoice_1.redeem_coupon
      invoice_2.redeem_coupon
      invoice_3.redeem_coupon

      expect(coupon.count_successful_uses).to eq(3)       
    end
  end
end
