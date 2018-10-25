module Clicksign
  module Webhooks
    class Engine < ::Rails::Engine
      isolate_namespace Clicksign::Webhooks
    end
  end
end
