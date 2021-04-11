class AddRefreshTokenAndOauthToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :refresh_token, :string
    add_column :users, :gmail_oauth, :boolean, default: :false
  end
end
