require_dependency 'rpush_web/application_controller'

class RpushWeb::DevicesController < ApplicationController
  skip_before_filter :verify_authenticity_token  
  layout 'rpush_web'

  def index
    @collection = RpushWeb::Device.all.page(params[:page]).per(20)
  end

  def register
    device = RpushWeb::Device.find_or_create_by(token: params[:token], platform: params[:platform])
    response = device.persisted? ? 200 : 201

    if device.save
      render json: { device: device }, root: false, status: response
    else
      render json: { errors: device.errors }, status: :unprocessable_entity
    end
  end

  def deregister
    device = RpushWeb::Device.where(token: params[:token]).first

    if device.nil?
      render nothing: true, status: :not_found
    elsif device.destroy
      render nothing: true, status: :ok
    else
      render json: { errors: device.errors }, status: :unprocessable_entity
    end
  end

end
