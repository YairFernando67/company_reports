class CreateShipments < ActiveRecord::Migration[6.0]
  def change
    create_table :shipments do |t|
      t.references :company, null: false, foreign_key: true
      t.references :sale, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.text :instructions
      t.integer :status
      t.integer :total_products
      t.integer :sale_number
      t.datetime :issued_at
      t.datetime :shiped_at

      t.timestamps
    end
  end
end
