class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order
  
  enum crafting_status: { production_not_possible: 0, production_pending: 1, in_production: 2, production_complete: 3 }
  
  def subtotal
    item.with_tax_price * quantity
  end
  
end
