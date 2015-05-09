class AddAuthenticateTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :authenticate_token, :string
  end
end
