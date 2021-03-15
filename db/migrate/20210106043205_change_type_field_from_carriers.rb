# frozen_string_literal: true

class ChangeTypeFieldFromCarriers < ActiveRecord::Migration[6.0]
  def change
    change_column :carriers, :type, :string
    # Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
