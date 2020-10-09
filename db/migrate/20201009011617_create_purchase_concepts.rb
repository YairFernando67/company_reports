class CreatePurchaseConcepts < ActiveRecord::Migration[6.0]
  def change
    create_table :purchase_concepts do |t|
      t.references :purchase, null: false, foreign_key: true
      t.string :unit_price
      t.string :total
      t.string :amount
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
