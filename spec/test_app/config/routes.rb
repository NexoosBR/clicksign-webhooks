Rails.application.routes.draw do
  mount Clicksign::Webhooks::Engine => "/clicksign-webhooks"
end
