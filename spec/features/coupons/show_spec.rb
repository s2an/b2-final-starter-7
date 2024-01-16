require "rails_helper"

RSpec.describe "merchant coupon show" do
  before :each do
    @merchant = create(:merchant)
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
      @coupon = create(:coupon, merchant: @merchant)

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
  
  describe "US4: Merchant Coupon Deactivate" do
    # As a merchant 
    # When I visit one of my active coupon's show pages
    # I see a button to deactivate that coupon
    # When I click that button
    # I'm taken back to the coupon show page 
    # And I can see that its status is now listed as 'inactive'.
    
    it "adds a deactivate button and deactivates the merchant coupon" do
      @coupon = create(:coupon, merchant: @merchant, status: :active)
      
      visit merchant_coupon_path(@merchant, @coupon)
      expect(current_path).to eq(merchant_coupon_path(@merchant, @coupon))
      
      expect(@coupon.status).to eq("active")
      expect(page).to have_button("Deactivate")

      click_button "Deactivate"
      @coupon.reload
      
      expect(current_path).to eq(merchant_coupon_path(@merchant, @coupon))
      expect(@coupon.status).to eq("inactive")
    end

    it "SP1: A coupon cannot be deactivated if there are any pending invoices with that coupon." do

    end
  end

  describe "US5: Merchant Coupon Activate" do
    # As a merchant 
    # When I visit one of my inactive coupon show pages
    # I see a button to activate that coupon
    # When I click that button
    # I'm taken back to the coupon show page 
    # And I can see that its status is now listed as 'active'.

    it "adds an activate button and activates the merchant coupon" do
      @coupon = create(:coupon, merchant: @merchant, status: :inactive)

      visit merchant_coupon_path(@merchant, @coupon)
      expect(current_path).to eq(merchant_coupon_path(@merchant, @coupon))
      
      expect(@coupon.status).to eq("inactive")
      expect(page).to have_button("Activate")

      click_button "Activate"
      @coupon.reload
      
      expect(current_path).to eq(merchant_coupon_path(@merchant, @coupon))
      expect(@coupon.status).to eq("active")

    end
  end


end