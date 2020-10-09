class CreatePurchases < ActiveRecord::Migration[6.0]
  def change
    create_table :purchases do |t|
      t.integer :seller_id
      t.integer :buyer_id
      t.decimal :total
      t.integer :status
      t.string :purchase_type

      t.timestamps
    end
    add_index :purchases, :seller_id
    add_index :purchases, :buyer_id
  end
end
