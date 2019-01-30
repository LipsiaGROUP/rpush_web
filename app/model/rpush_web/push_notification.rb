module RpushWeb
	class PushNotification < ActiveRecord::Base
		

    Platform_list = [['general', 0], ['ios', 1], ['android', 2]]

		validates :content, length: { maximum: 230 }
		validates :title, :content, presence: true

		after_create :setup_push_notification

		def setup_push_notification
			RpushWeb::SetupNotificationJob.perform_later(self.id) 
		end

		def platform_name
			case platform 
			when 0 
				'general'
			when 1
				'ios'
			else
				'android'
			end
		end

		def self.send_android(user_token, data = {}, data_content = {})
			n = Rpush::Gcm::Notification.new
			n.app = Rpush::Gcm::App.last
			if n.app
				n.registration_ids = [user_token]
				n.data = data_content
				n.priority = 'high'        # Optional, can be either 'normal' or 'high'
				n.content_available = true # Optional
				# Optional notification payload. See the reference below for more keys you can use!
				n.notification = {body: data["title"], title: data["content"]}
				n.save!
			end
		end

		def self.send_ios(user_token, data = {}, data_content = {})
			n = Rpush::Apns::Notification.new
			n.app = Rpush::Apns::App.last
			if n.app
				n.device_token = user_token
				# n.alert = data["content"]
				n.alert = { title: data["title"], body: data["content"] }
				n.data = data_content
				n.save!
			end
		end

	end
end