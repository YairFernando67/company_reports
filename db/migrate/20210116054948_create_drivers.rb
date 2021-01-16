class CreateDrivers < ActiveRecord::Migration[6.0]
  def change
    create_table :drivers do |t|
      t.string :name
      t.string :last_name
      t.string :email
      t.string :phone
      t.integer :driver_number
      t.integer :status
      t.references :carrier, null: false, foreign_key: true
      t.string :licence_number

      t.timestamps
    end
  end
end
