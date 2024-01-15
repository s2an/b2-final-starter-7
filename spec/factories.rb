FactoryBot.define do
  factory :coupon do
    name {Faker::Commerce.promotion_code(digits: 0)}
    unique_code {Faker::Barcode.unique.ean}
    value {[5,10,25,50,75].sample}
    value_type {["%", "$"].sample}
    active {false}
    merchant
  end

  factory :customer do
    first_name {Faker::Name.first_name}
    last_name {Faker::Dessert.variety}
  end

  factory :invoice do
    status {[0,1,2].sample}
    # merchant
    customer

    trait :with_coupon do
      coupon
    end
  end

  factory :merchant do
    name {Faker::Space.galaxy}
    # invoices
    # items
  end

  factory :item do
    name {Faker::Coffee.variety}
    description {Faker::Hipster.sentence}
    unit_price {Faker::Number.decimal(l_digits: 2)}
    merchant
  end

  factory :transaction do
    result {[0,1].sample}
    credit_card_number {Faker::Finance.credit_card}
    invoice
  end

  factory :invoice_item do
    quantity {[1,2,3,4,5].sample}
    unit_price {Faker::Commerce.price}
    status {[0,1,2].sample}
    # merchant
    invoice
    item
  end
end
