class CreateSales < ActiveRecord::Migration[6.0]
  def change
    create_table :sales do |t|
      t.integer :seller_id
      t.integer :buyer_id
      t.decimal :total
      t.integer :status
      t.string :sale_type

      t.timestamps
    end
    add_index :sales, :seller_id
    add_index :sales, :buyer_id
  end
end
