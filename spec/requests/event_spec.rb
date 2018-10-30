require 'spec_helper'

RSpec.describe Clicksign::Webhooks::EventsController, type: :request do
  let(:on_upload) do
    Proc.new { |event| event }
  end

  context 'valid request and valid setup' do
    before do
      Clicksign::Webhooks.configure do |config|
        config.hmac = ENV['CLICKSIGN_HMAC']
        config.on_upload = on_upload
      end
    end

    # Please, notice that `request.body` will be like:
    # event[name]=upload
    # It will be usefull to generate testing HMACs
    let(:params) {
      { event: { name: 'upload' } }
    }

    it do
      expect(on_upload).to receive(:call).once

      post '/clicksign-webhooks/event', params: params, headers: {
        "Content-Hmac": "sha256=\"#{ENV['VALID_CONTENT_HMAC_HEADER']}\""
      }

      expect(response.code).to eq('200')
    end
  end

  context 'invalid setup' do
    before do
      Clicksign::Webhooks.configure do |config|
        config.hmac = 'INVALID'
        config.on_upload = on_upload
      end
    end

    it do
      expect(on_upload).to_not receive(:call)
      post '/clicksign-webhooks/event', params: {}, headers: {}
      expect(response.code).to eq('401')
    end
  end

  context 'invalid request' do
    before do
      Clicksign::Webhooks.configure do |config|
        config.hmac = ENV['CLICKSIGN_HMAC']
        config.on_upload = on_upload
      end
    end

    # Please, notice that `request.body` will be like:
    # event[name]=invalid
    # It will be usefull to generate testing HMACs
    let(:params) do
      { event: { name: 'invalid' } }
    end

    it do
      expect(on_upload).to_not receive(:call)
      expect(Rails.logger).to receive(:warn).with('Invalid configuration: on_invalid')

      post '/clicksign-webhooks/event', params: { event: { name: 'invalid' } }, headers: {
        'Content-Hmac': "sha256=\"#{ENV['INVALID_CONTENT_HMAC_HEADER']}\""
      }
      expect(response.code).to eq('422')
    end
  end
end
