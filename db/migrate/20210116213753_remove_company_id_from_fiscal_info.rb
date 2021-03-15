# frozen_string_literal: true

class RemoveCompanyIdFromFiscalInfo < ActiveRecord::Migration[6.0]
  def change
    remove_column :fiscal_infos, :company_id
  end
end
