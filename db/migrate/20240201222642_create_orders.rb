class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :client, null: false, foreign_key: true
      t.integer :status, null: false, default: 0
      t.decimal :subtotal, null: false, :precision => 10, :scale => 2
      t.decimal :tax, null: false, :precision => 10, :scale => 2
      t.decimal :total, null: false, :precision => 10, :scale => 2
      t.integer :payment_method, null: false

      t.timestamps
    end
  end
end
