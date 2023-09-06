class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  
  validates :item_id, :amount, presence: true
  validates :amount, numericality:{ only_integer: true }

  def subtotal
    item.with_tax_price * amount
  end
end
