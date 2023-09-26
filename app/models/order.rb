class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  
  
  
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum select_address: { current_customer_address: 0, addresses: 1, new_address: 2 }
  enum status: { payment_waiting: 0, payment_confirmation: 1, in_production: 2, preparing_delivery: 3, delivered: 4 }
end
