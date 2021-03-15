# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :external_number
      t.string :country
      t.string :city
      t.string :state
      t.string :zip_code
      t.integer :addressable_id
      t.string :addressable_type

      t.timestamps
    end
  end
end
