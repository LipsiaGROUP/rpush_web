class RpushWeb::SetupNotificationJob < ActiveJob::Base
  queue_as :default
 
  def perform(id)
    obj = RpushWeb::PushNotification.find(id)
    case obj.platform
    when 'ios'
    	devices = RpushWeb::Device.where(platform: 1)
    when 'android'
    	devices = RpushWeb::Device.where(platform: 2)
    else
    	devices = RpushWeb::Device.all
    end

    devices.uniq!
		devices.each do |device|
			RpushWeb::SendPushNotificationJob.perform_now(obj.title, obj.content, device.token, device.platform)
		end

  end
end