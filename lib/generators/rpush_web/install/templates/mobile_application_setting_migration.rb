class RpushWebCreateMobileApplicationSetting < ActiveRecord::Migration
  def change
    create_table :rpush_web_mobile_application_settings do |t|
      t.string :app_name
      t.string :android_auth_key
      t.string :ios_certificate
      t.string :environment_level
      t.string :connections

      t.timestamps null: false
    end
  end
end
