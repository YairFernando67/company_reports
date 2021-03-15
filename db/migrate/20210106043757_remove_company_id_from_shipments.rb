# frozen_string_literal: true

class RemoveCompanyIdFromShipments < ActiveRecord::Migration[6.0]
  def change
    remove_column :shipments, :company_id
  end
end
