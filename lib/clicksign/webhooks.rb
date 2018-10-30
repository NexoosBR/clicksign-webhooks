require "clicksign/webhooks/version"
require "clicksign/webhooks/engine"
require "clicksign/webhooks/hmac"

begin
  require "dotenv/load"
  require "byebug"
rescue LoadError
end

module Clicksign
  module Webhooks
    EVENTS = [
      :upload, :add_signer, :remove_signer, :sign, :close, :auto_close,
      :deadline, :cancel, :update_deadline, :update_auto_close
    ].map { |event| "on_#{event}" }

    DEFAULT_EVENT_HANDLER = -> (event) {
      "Missing config for event: #{event.inspect}".tap do |message|
        Rails.logger.debug(message)
      end
    }

    class << self

      attr_accessor :hmac, *EVENTS

      def configure
        yield(self) if block_given?
      end
    end
  end
end
