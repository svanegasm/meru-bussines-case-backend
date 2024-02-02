class CreateOrderProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :order_products do |t|
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity, null: false
      t.decimal :unit_price, null: false, :precision => 10, :scale => 2
      t.decimal :tax_value, null: false, :precision => 10, :scale => 2
      t.decimal :discount_value, null: false, :precision => 10, :scale => 2
      t.decimal :total_products_price, null: false, :precision => 10, :scale => 2

      t.timestamps
    end
  end
end
