class RpushWeb::SendPushNotificationJob < ActiveJob::Base
  queue_as :default
 
  def perform(title, content, token, platform)
    if platform.eql?('ios')
      RpushWeb::PushNotification.send_ios(token, {"title" => title, "content" => content})
    else
      RpushWeb::PushNotification.send_android(token, {"title" => title, "content" => content})
    end
  end
end