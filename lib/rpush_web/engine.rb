module RpushWeb
  class Engine < ::Rails::Engine
    isolate_namespace RpushWeb

    initializer "rpushweb.routes" do
      RpushWeb::Rails::Routes.install!
    end

    config.generators do |g|
      g.assets false
      g.helper false
    end
  end
end
