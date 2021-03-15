# frozen_string_literal: true

class CreateCarriers < ActiveRecord::Migration[6.0]
  def change
    create_table :carriers do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.boolean :type
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
