# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Rake::Task["csv_load:all"].invoke

merchants = Merchant.create([{ name: "Merchant 1", status: 1 }, { name: "Merchant 2", status: 0 }])

coupons = Coupon.create([{ name: "SpringSale2024", unique_code: "SPRING24", value: 10, status: "active", merchant_id: 1, value_type: "%", redemptions: 2 },
                          { name: "SummerSale2024", unique_code: "SUMMER24", value: 15, status: "inactive", merchant_id: 2, value_type: "$", redemptions: 3 },
                          { name: "FallSale2024", unique_code: "FALL24", value: 20, status: "active", merchant_id: 3, value_type: "$", redemptions: 4 },
                          { name: "WinterSale2024", unique_code: "WINTER24", value: 5, status: "active", merchant_id: 3, value_type: "$", redemptions: 4 },
                          { name: "AutumnSale2024", unique_code: "AUTUMN24", value: 50, status: "active", merchant_id: 3, value_type: "$", redemptions: 5 },
                          { name: "SeasonSale2024", unique_code: "SEASON24", value: 200, status: "active", merchant_id: 4, value_type: "%", redemptions: 5 }])

customers = Customer.create([{ first_name: "John", last_name: "Doe", address: "123 Main St", city: "Richmond", state: "VA", zip: 12345 },
                             { first_name: "Jane", last_name: "Smith", address: "123 Other Rd", city: "Roanoke", state: "VA", zip: 54321 }])

items = Item.create([{ name: "Shampoo", description: "Washes hair", unit_price: 10, merchant_id: 1, status: 0 },
                     { name: "Conditioner", description: "Conditions hair", unit_price: 20, merchant_id: 2, status: 1 }])

invoices = Invoice.create([{ customer_id: 1, status: 0, coupon_id: 1 },
                           { customer_id: 2, status: 1, coupon_id: 2 }])

invoice_items = InvoiceItem.create([{ quantity: 2, unit_price: 10, status: 0, invoice_id: 1, item_id: 1 },
                                    { quantity: 3, unit_price: 20, status: 1, invoice_id: 2, item_id: 2 }])

transactions = Transaction.create([{ credit_card_number: 1234567890123456, credit_card_expiration_date: 1111, result: 0, invoice_id: 1 },
                                   { credit_card_number: 9876543210987650, credit_card_expiration_date: 2222, result: 1, invoice_id: 2 }])