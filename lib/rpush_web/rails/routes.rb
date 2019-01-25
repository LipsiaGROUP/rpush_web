require 'rpush_web/rails/routes/mapping'
require 'rpush_web/rails/routes/mapper'

module RpushWeb
  module Rails
    class Routes
      module Helper
        def mount_rpush_web(options = {}, &block)
          RpushWeb::Rails::Routes.new(self, &block).generate_routes!(options)
        end
      end

      def self.install!
        ActionDispatch::Routing::Mapper.send :include, RpushWeb::Rails::Routes::Helper
      end

      attr_accessor :routes

      def initialize(routes, &block)
        @routes, @block = routes, block
      end

      def generate_routes!(options)
        @mapping = Mapper.new.map(&@block)
        routes.scope options[:scope] || 'rpush_web', as: 'rpush_web' do
          map_route(:devices, :device_routes)
          map_route(:mobile_application_settings, :mobile_application_setting_routes)
          map_route(:push_notifications, :push_notification_routes)
        end
      end

      private

      def map_route(name, method)
        unless @mapping.skipped?(name)
          send method, @mapping[name]
        end
      end

      def mobile_application_setting_routes(mapping)
        routes.resources(
          :mobile_application_settings,
          controller: mapping[:controllers],
          as: :mobile_application_settings,
          path: 'mobile_application_settings')
      end

      def push_notification_routes(mapping)
        routes.resources(
          :push_notifications,
          controller: mapping[:controllers],
          as: :push_notifications,
          path: 'push_notifications')
      end

      def device_routes(mapping)
        routes.resources(
          :devices,
          controller: mapping[:controllers],
          as: :devices,
          path: 'devices',
          only: [:index],
        ) do |scope|
          routes.put    ':token', controller: mapping[:controllers], action: :register, on: :collection
          routes.delete ':token', controller: mapping[:controllers], action: :deregister, on: :collection
        end
      end
    end
  end
end
