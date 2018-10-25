Clicksign::Webhooks::Engine.routes.draw do
  resource :event, only: [:create]
end
