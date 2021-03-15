# frozen_string_literal: true

class AddFieldsToFiscalInfoToMakeItPolymorphic < ActiveRecord::Migration[6.0]
  def change
    add_column :fiscal_infos, :fiscal_infoable_type, :string
    add_column :fiscal_infos, :fiscal_infoable_id, :integer
  end
end
