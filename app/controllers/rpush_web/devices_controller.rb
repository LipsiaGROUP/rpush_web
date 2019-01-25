require_dependency 'rpush_web/application_controller'

class RpushWeb::DevicesController < ApplicationController
    # before_action :authenticate!
  layout 'rpush_web'

  def index
    @collection = RpushWeb::Device.all.page(params[:page]).per(20)
  end

  def register
    if user 
      @device = RpushWeb::Device.new(owner: user, token: params[:token])
    else
      @device = RpushWeb::Device.find_or_create_by(token: params[:token])
    end

    @device.platform = detect_platform

    response = @device.persisted? ? 200 : 201

    if @device.save
      render json: { device: @device }, root: false, status: response
    else
      render json: { errors: @device.errors }, status: :unprocessable_entity
    end
  end

  def deregister
    @device = RpushWeb::Device.where(token: params[:token]).first

    if @device.nil?
      render nothing: true, status: :not_found
    elsif @device.destroy
      render nothing: true, status: :ok
    else
      render json: { errors: @device.errors }, status: :unprocessable_entity
    end
  end

  private

  def authenticate!
    method(RpushWeb.authentication_method).call
  end

  def user
    @user ||= method(RpushWeb.current_user_method).call
  end


end
