class RenameCarrierTypeColumnFromCarriers < ActiveRecord::Migration[6.0]
  def change
    rename_column :carriers, :type, :carrier_type
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
