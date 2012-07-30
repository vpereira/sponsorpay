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
    #SponsorPay::Request.new(params).get
    #http = EM::HttpRequest.new(url).get head: HEADERS
    [200, {'X-Goliath' => 'Proxy','Content-Type' => 'application/json'}, {:foo=>"bar"}.to_json]
  end
end