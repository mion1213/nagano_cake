class Address < ApplicationRecord
  belongs_to :customer
  
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :name, presence: true
  
  enum address_type: {current_customer_address: 0, addresses: 1, new_address: 2}
  
  def address_display
    '〒' + postal_code + ' ' + address + ' ' + name
  end
  
end
