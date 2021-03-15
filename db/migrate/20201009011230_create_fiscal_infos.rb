# frozen_string_literal: true

class CreateFiscalInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :fiscal_infos do |t|
      t.string :ri
      t.string :account_statement
      t.string :proof_of_address
      t.string :incorporation_act
      t.datetime :start_of_operation

      t.timestamps
    end
  end
end
