require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "validations" do
    it { should validate_presence_of :status }
    it { should validate_presence_of :customer_id }
  end
  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many :transactions}
  end
  describe "instance methods" do
    it "total_revenue" do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
      @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
      @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 2)
      @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 1, unit_price: 10, status: 1)

      expect(@invoice_1.total_revenue).to eq(100)
    end
    
    it "subtotal and grand_total_revenue" do
      merchant = Merchant.create!(name: "Hair Care")
      coupon = create(:coupon, merchant: merchant, value: 50, value_type: "%", status: "active")
      item = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: merchant.id, status: 1)
      customer = Customer.create!(first_name: "Joey", last_name: "Smith")
      invoice = Invoice.create!(customer_id: customer.id, status: 2, coupon: coupon)
      ii = InvoiceItem.create!(invoice_id: invoice.id, item_id: item.id, quantity: 1, unit_price: 10, status: 2)
      transaction = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: invoice.id)
      
      expect(invoice.subtotal).to eq(10)
      expect(invoice.grand_total_revenue).to eq(5)
    end

    it "redeem_coupon" do
      merchant = create(:merchant)
      coupon = create(:coupon, merchant: merchant)
      customer = create(:customer)
      invoice = create(:invoice, customer: customer, coupon: coupon, status: "in_progress")
      item = create(:item, merchant: merchant)
      ii = create(:invoice_item, invoice: invoice, item: item)
      transaction = create(:transaction, invoice: invoice, result: "success")
# require 'pry'; binding.pry it works in the pry session!
      expect{ invoice.redeem_coupon }.to change{ coupon.redemptions }.by(1)
    end

    it "does not redeem a coupon if it already has five redemptions" do
      merchant = create(:merchant)
      coupon = create(:coupon, merchant: merchant)
      customer = create(:customer)
      invoice = create(:invoice, customer: customer, coupon: coupon, status: "in_progress")
      item = create(:item, merchant: merchant)
      ii = create(:invoice_item, invoice: invoice, item: item)
      transaction = create(:transaction, invoice: invoice, result: "success")
      
      invoice.redeem_coupon
      invoice.redeem_coupon
      invoice.redeem_coupon
      invoice.redeem_coupon
      invoice.redeem_coupon
# require 'pry'; binding.pry also works in the pry session!
      expect(coupon.redemptions).to eq(5)
    end
  end
end
