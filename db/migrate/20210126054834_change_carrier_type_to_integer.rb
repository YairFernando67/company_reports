class ChangeCarrierTypeToInteger < ActiveRecord::Migration[6.0]
  def change
    remove_column :carriers, :carrier_type
    add_column :carriers, :carrier_type, :integer
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email") :carriers, :carrier_type, :integer
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
