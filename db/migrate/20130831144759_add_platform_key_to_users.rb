class AddPlatformKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :platform_key, :string
  end
end
