# frozen_string_literal: true

class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :business_name
      t.string :rfc
      t.string :email
      t.string :phone
      t.string :active
      t.string :contact
      t.references :user, null: false, foreign_key: true
      t.string :fiscal_name
      t.integer :company_type_id

      t.timestamps
    end
    add_index :companies, :company_type_id
  end
end
