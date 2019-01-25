require_dependency 'rpush_web/application_controller'

class RpushWeb::MobileApplicationSettingsController < ApplicationController
  include Rails.application.routes.url_helpers
	layout 'rpush_web'

  before_action :set_obj, only: [:edit, :destroy]

  def index
    @collection = RpushWeb::MobileApplicationSetting.all
  end

  def new
    @mobile_application_setting = RpushWeb::MobileApplicationSetting.new
  end

  def create
    @mobile_application_setting = RpushWeb::MobileApplicationSetting.new(mobile_application_setting_param)
    if @mobile_application_setting.save
      redirect_to rpush_web_mobile_application_settings_url
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @mobile_application_setting = RpushWeb::MobileApplicationSetting.find(params[:id])
    if @mobile_application_setting.update_attributes(mobile_application_setting_param)
      flash[:notice] = "Successfully updated account!"
      redirect_to rpush_web_mobile_application_settings_url
    else
      render 'edit'
    end
  end

  private

    def set_obj
      @mobile_application_setting = RpushWeb::MobileApplicationSetting.find(params[:id])
    end

    def mobile_application_setting_param
      params.require(:mobile_application_setting).permit(:app_name, :android_auth_key, :ios_certificate, :environment_level, :connections)
    end
end