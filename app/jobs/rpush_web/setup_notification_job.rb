class RpushWeb::SetupNotificationJob < ActiveJob::Base
  queue_as :default
 
  def perform(id)
    obj = RpushWeb::PushNotification.find(id)
    case obj.platform
    when 1
    	devices = RpushWeb::Device.where(platform: 1)
    when 2
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