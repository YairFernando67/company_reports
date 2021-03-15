# frozen_string_literal: true

class AddCompanyReferencesToFiscalInfos < ActiveRecord::Migration[6.0]
  def change
    add_reference :fiscal_infos, :company, foreign_key: true
  end
end
