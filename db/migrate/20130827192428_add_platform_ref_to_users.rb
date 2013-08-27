class AddPlatformRefToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :platform, index: true
  end
end
