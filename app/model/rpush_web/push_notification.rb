module RpushWeb
	class PushNotification < ActiveRecord::Base
		# OS:
    enum platform: {
    	general: 0,
      ios: 1,
      android: 2
    }

    Platform = [['general'], ['ios'], ['android']]

		validates :content, length: { maximum: 230 }
		validates :title, :content, presence: true

		after_create :setup_push_notification

		def setup_push_notification
			RpushWeb::SetupNotificationJob.perform_later(self.id) 
		end

		def self.send_android(user_token, data = {})
			n = Rpush::Gcm::Notification.new
			n.app = Rpush::Gcm::App.last
			if n.app
				n.registration_ids = [user_token]
				# n.data = {
				# 	treatment_name: treatment[:des_treatment]
				# }
				n.priority = 'high'        # Optional, can be either 'normal' or 'high'
				n.content_available = true # Optional
				# Optional notification payload. See the reference below for more keys you can use!
				n.notification = {body: data["title"], title: data["content"]}
				n.save!
			end
		end

		def self.send_ios(user_token, data = {})
			n = Rpush::Apns::Notification.new
			n.app = Rpush::Apns::App.last
			if n.app
				n.device_token = user_token
				# n.alert = data["content"]
				n.alert = { title: data["title"], body: data["content"] }
				# n.data = {
				# 	treatment_name: treatment[:des_treatment]
				# }
				n.save!
			end
		end

	end
end