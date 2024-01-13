require 'rails_helper'

RSpec.describe Coupon, type: :model do
  describe "relationships" do
    it { should belong_to(:merchant) }
    it { should belong_to(:invoice) }
    end
end
