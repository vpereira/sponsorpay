#!/usr/bin/env ruby

# Rewrites and proxies requests to a third-party API, with HTTP basic authentication.

require "rubygems"
require "bundler/setup"
require 'goliath'
require 'em-synchrony/em-http'
require 'json'
require File.join(File.dirname(__FILE__),"lib","sponsor_pay","request")

class SponsorPayHandler < Goliath::API
  use Goliath::Rack::Params
  use Goliath::Rack::JSONP
  use Goliath::Rack::Render 

  
  def response(env)
    params = {}
    http = SponsorPay::Request.new(params).get
    [200, {'X-SponsorPay' => 'Proxy','Content-Type' => 'application/json'}, http.response]
  end
end
