class RpushWebCreateDevices < ActiveRecord::Migration
  def change
    create_table :rpush_web_devices do |t|
      t.string :token
      t.integer :owner_id
      t.string :owner_type
      t.integer :platform

      t.timestamps null: false
    end

    add_index :rpush_web_devices, [:owner_id, :owner_type]
    add_index :rpush_web_devices, :token
  end
end
