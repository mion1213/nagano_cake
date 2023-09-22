class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.integer :item_id, null: false
      t.integer :order_id, null: false
      t.integer :price_including_tax, null: false
      t.integer :quantity, null: false
      t.integer :crafting_status, null: false, default: 0

      t.timestamps
    end
  end
end
