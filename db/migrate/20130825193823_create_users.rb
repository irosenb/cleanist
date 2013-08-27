class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :token
      # t.string :platform

      t.timestamps
    end
  end
end
