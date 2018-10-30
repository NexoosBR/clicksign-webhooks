module Clicksign
  module Webhooks
    class ApplicationController < ActionController::Base
      before_action do
        Clicksign::Webhooks::HMAC.new(request).validate!
      end

      rescue_from InvalidHMACError do
        Rails.logger.warn("Invalid HMAC")
        head 401
      end
    end
  end
end
