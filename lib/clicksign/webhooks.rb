require "clicksign/webhooks/engine"
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

    class << self
      attr_accessor *EVENTS

      def configure
        yield(self) if block_given?
      end
    end
  end
end
