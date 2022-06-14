FROM ruby:2.7.6-alpine

RUN apt-get update -qq
RUN apt-get install -y nodejs

RUN mkdir /clicksign_webhooks
WORKDIR /clicksign_webhooks

COPY clicksign-webhooks.gemspec /clicksign_webhooks/clicksign-webhooks.gemspec
COPY Gemfile /clicksign_webhooks/Gemfile
COPY Gemfile.lock /clicksign_webhooks/Gemfile.lock
COPY lib/clicksign/webhooks/version.rb /clicksign_webhooks/lib/clicksign/webhooks/version.rb

RUN bundle install

ADD . /clicksign_webhooks
