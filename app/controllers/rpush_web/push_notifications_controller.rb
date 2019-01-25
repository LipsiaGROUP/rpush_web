require_dependency 'rpush_web/application_controller'

class RpushWeb::PushNotificationsController < ApplicationController
  include Rails.application.routes.url_helpers
	layout 'rpush_web'

  def index
    @collection = RpushWeb::PushNotification.all
  end

  def show
    @push_notification = RpushWeb::PushNotification.find(params[:id])
  end

  def new
    @push_notification = RpushWeb::PushNotification.new
  end

  def create
    @push_notification = RpushWeb::PushNotification.new(push_notification_param)
    if @push_notification.save
      redirect_to rpush_web_push_notifications_url
    else
      render 'new'
    end
  end

  private

    def push_notification_param
      params.require(:push_notification).permit(:title, :content, :platform) # Look up strong params if you are unfamiliar. The name, email, etc. are going to be the only permitted params passed in the methods above as a safety feature so you have to permit the fields being created here.
    end
end