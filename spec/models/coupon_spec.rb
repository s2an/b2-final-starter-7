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
      coupon = create(:coupon, merchant: merchant, status: "active")
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

    it "tests coupon limit" do
      merchant = create(:merchant)
      customer = create(:customer)
      coupon1 = create(:coupon, merchant: merchant, status: "active")
      coupon2 = create(:coupon, merchant: merchant, status: "active")
      coupon3 = create(:coupon, merchant: merchant, status: "active")
      coupon4 = create(:coupon, merchant: merchant, status: "active")
      coupon5 = create(:coupon, merchant: merchant, status: "active")
      expect { create(:coupon, merchant: merchant, status: "active") }.to raise_error(ActiveRecord::RecordInvalid)
      # require 'pry'; binding.pry the validates fails it because it cannot make it
# require 'pry'; binding.pry
      # expect(coupon6.valid?).to be false
      # expect(coupon6.errors[:base]).to include("Merchant has maximum amount of coupons (5)")
    end
  end
end
