require 'rails_helper'

RSpec.describe Coupon, type: :model do
  describe "relationships" do
    it { should belong_to(:merchant) }
    it { should have_many(:invoices) }
  end

  describe "method tests" do
    it "counts the number of times it has shown up on an invoice" do
      coupon = create(:coupon)
      invoice = create(:invoice, coupon: coupon)

      expect(coupon.redemption_count).to eq(1)

      invoice2 = create(:invoice, coupon: coupon)
      expect(coupon.redemption_count).to eq(2)

      invoice3 = create(:invoice, coupon: coupon)
      invoice4 = create(:invoice, coupon: coupon)
      invoice5 = create(:invoice, coupon: coupon)
      expect(coupon.redemption_count).to eq(5)
      
      # invoice6 = create(:invoice, coupon: coupon)
    end
  end

end
