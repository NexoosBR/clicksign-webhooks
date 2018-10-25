require 'spec_helper'

RSpec.describe Clicksign::Webhooks::EventsController, type: :request do
  let(:on_upload) do
    Proc.new { |event| event }
  end

  before do
    Clicksign::Webhooks.configure do |config|
      config.on_upload = on_upload
    end
  end

  it do
    expect(on_upload).to receive(:call).once
    post '/clicksign-webhooks/event', params: { event: { name: 'upload' } }
    expect(response.code).to eq('200')
  end

  it do
    expect(on_upload).to_not receive(:call)
    post '/clicksign-webhooks/event', params: { event: { name: 'invalid' } }
    expect(response.code).to eq('422')
  end
end
