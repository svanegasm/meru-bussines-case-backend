class CreateClients < ActiveRecord::Migration[6.1]
  def change
    create_table :clients do |t|
      t.string :identification, null: false
      t.string :full_name, null: false
      t.string :phone, null: false
      t.string :email

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
