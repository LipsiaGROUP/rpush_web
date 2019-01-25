class RpushWebCreatePushNotifications < ActiveRecord::Migration
  def change
    create_table :rpush_web_push_notifications do |t|
      t.string :title
      t.text :content
      t.integer :platform

      t.timestamps null: false
    end
  end
end
