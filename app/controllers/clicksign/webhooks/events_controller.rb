require_dependency "clicksign/webhooks/application_controller"

module Clicksign::Webhooks
  class EventsController < ApplicationController
    def create
      Clicksign::Webhooks.send(callback).call(event_params)
      head 200
    rescue NoMethodError
      Rails.logger.warn("Invalid configuration: #{callback}")
      head 422
    end

    def event_params
      params.require(:event).permit!
    end

    def callback
      "on_#{event_params[:name]}"
    end
  end
end
