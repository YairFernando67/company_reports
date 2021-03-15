# frozen_string_literal: true

class ChangeSaleNumberTypeFromShipments < ActiveRecord::Migration[6.0]
  def change
    change_column :shipments, :sale_number, :string
  end
end
