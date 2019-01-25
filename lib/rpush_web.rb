require 'rpush_web/engine'
require 'rpush_web/rails/routes'

require 'responders'

module RpushWeb
  extend ActiveSupport::Autoload

  autoload :ActsAsDeviceOwner, 'rpush_web/acts_as_device_owner'

  # Method to authenticate a user:
  mattr_accessor :authentication_method
  @@authentication_method = nil

  # Method to retrieve the current authenticated user:
  mattr_accessor :current_user_method
  @@current_user_method = nil

  private

  # Default way to setup Dre:
  def self.setup
    yield self
  end
end

module ActiveRecord
  class Base
    include RpushWeb::ActsAsDeviceOwner
  end
end
