module RpushWeb
  class MobileApplicationSetting < ActiveRecord::Base
    mount_uploader :ios_certificate, CertificateUploader

    before_validation :setup_default
    after_save :setup_rpush_app
    validates :app_name, presence: true 

    def setup_default
      self.environment_level = ::Rails.env if self.environment_level.blank?
      self.connections = 1 if self.connections.blank?
    end

    def setup_rpush_app
      if self.ios_certificate.present?
        register_ios
      end

      if self.android_auth_key.present?
        register_android
      end
    end

    def register_ios
      app = Rpush::Apns::App.where(name: self.app_name).first
      unless app
        app = Rpush::Apns::App.new(name: self.app_name)
      end
      app.certificate = File.read(self.ios_certificate.current_path)
      app.environment = self.environment_level
      app.connections = self.connections
      app.save!
    end

    def register_android
      app = Rpush::Gcm::App.where(name: self.app_name).first
      unless app
        app = Rpush::Gcm::App.new(name: self.app_name)
      end
      app.auth_key = self.android_auth_key
      app.connections = self.connections
      app.save!
    end

  end
end