require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe "validations" do
    it { should validate_presence_of :invoice_id }
    it { should validate_presence_of :credit_card_number }
    it { should validate_presence_of :result }
  end
  describe "relationships" do
    it { should belong_to :invoice }
  end

  it "redeems a coupon by adding to redemptions after successful transaction" do
    merchant = create(:merchant)
    coupon = create(:coupon, merchant: merchant)
    customer = create(:customer)
    invoice = create(:invoice, customer: customer, coupon: coupon)
    item = create(:item, merchant: merchant)
    ii = create(:invoice_item, invoice: invoice, item: item)
    transaction = create(:transaction, invoice: invoice)

    expect(transaction.redeem_coupon).to change(coupon.redemptions).by(1)
  end
end
