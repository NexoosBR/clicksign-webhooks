# Clicksign::Webhooks

To fully understand Clicksign webhooks system, click [here](https://developers.clicksign.com/docs/introducao-a-webhooks)

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'clicksign-webhooks'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install clicksign-webhooks
```

## Usage

First, mount this engine on your app.

```ruby
Rails.application.routes.draw do
  ...
  mount Clicksign::Webhooks::Engine => "/clicksign-webhooks"
  ...
end

```

Depending on your version of rails, use either `rails routes -g clicksign-webhooks` or `rake routes | grep clicksign-webhooks`, to see the path:

```bash
$ rake routes | grep clicksign-webhooks
Routes for Clicksign::Webhooks::Engine:
 event POST /event(.:format) clicksign/webhooks/events#create
```

Your rails app able to receive a `POST` at `/clicksign-webhooks/event`.

Then create a initializer using a `Proc` to each possible event:

```ruby
Clicksign::Webhooks.configure do |config|
  # You have to setup one Proc for each event

  config.on_upload = ->(event) {
    # Do something with sent event parameters
  }

  # ...
end
```

The argument `event` is a `Hash`:

```ruby
  {
     "event":{
        "name":"add_signer",
        "data":{
           "user":{
              "email":"...",
              "name":"..."
           },
           "account":{
              "key":"..."
           },
           "signers":[
              {
                 "key":"...",
                 "email":"...",
                 "created_at":"...",
                 "sign_as":"witness",
                 "auths":["email"],
                 "phone_number":"...",
                 "phone_number_hash":"..."
              }
           ]
        },
        "occurred_at":"..."
     },
     "document":{...},
     "signers":[...],
     "events":[{...}]
  }
```

##### Available event callbacks:

- on_upload
- on_add_signer
- on_remove_signer
- on_sign
- on_close
- on_auto_close,
- on_deadline
- on_cancel
- on_update_deadline
- on_update_auto_close

## Contributing

Feel free to contribute. Pull requests are welcome.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
