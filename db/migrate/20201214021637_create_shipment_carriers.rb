class CreateShipmentCarriers < ActiveRecord::Migration[6.0]
  def change
    create_table :shipment_carriers do |t|
      t.references :carrier, null: false, foreign_key: true
      t.references :shipment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
