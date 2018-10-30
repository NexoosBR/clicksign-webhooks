Clicksign::Webhooks.configure do |config|
  config.hmac = ENV['CLICKSIGN_HMAC_KEY']

  event_handler = -> (event) {
    Rails.logger.debug("EVENT: #{event.fetch(:name)}")
  }

  config.on_upload = event_handler
  config.on_add_signer = event_handler
  config.on_remove_signer = event_handler
  config.on_sign = event_handler
  config.on_close = event_handler
  config.on_auto_close = event_handler
  config.on_deadline = event_handler
  config.on_cancel = event_handler
  config.on_update_deadline = event_handler
  config.on_update_auto_close = event_handler
end
