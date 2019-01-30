module RpushWeb
  module ActsAsDeviceOwner
    extend ActiveSupport::Concern

    module ClassMethods
      def acts_as_device_owner(_options = {})
        has_many :devices, as: :owner, class_name: 'RpushWeb::Device'
      end
    end
  end
end