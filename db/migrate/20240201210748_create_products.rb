class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :description
      t.decimal :price, null: false, :precision => 10, :scale => 2
      t.integer :stock, null: false
      t.decimal :percentage_discount, :precision => 5, :scale => 2, default: 0.00
      t.decimal :percentage_tax, null: false, :precision => 5, :scale => 2, default: 16.00

      t.datetime :deleted_at
      t.timestamps
    end
  end
end