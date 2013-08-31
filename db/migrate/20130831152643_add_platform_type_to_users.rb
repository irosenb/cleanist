class AddPlatformTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :platform_type, :string
  end
end
