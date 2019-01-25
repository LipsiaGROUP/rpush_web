module RpushWeb
  module Rails
    class Routes
      class Mapping
        attr_accessor :controllers, :as, :skips

        def initialize
          @controllers = {
            devices: 'rpush_web/devices',
            push_notifications: 'rpush_web/push_notifications',
            mobile_application_settings: 'rpush_web/mobile_application_settings'
          }

          @as = {}
          @skips = []
        end

        def [](routes)
          {
            controllers: @controllers[routes],
            as: @as[routes]
          }
        end

        def skipped?(controller)
          @skips.include?(controller)
        end
      end
    end
  end
end
