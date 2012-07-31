#!/usr/bin/env ruby

# Rewrites and proxies requests to a third-party API, with HTTP basic authentication.

require "rubygems"
require "bundler/setup"
require 'goliath'
require 'em-synchrony/em-http'
require 'active_support'
require 'active_support/hash_with_indifferent_access'
require 'json'
require 'haml'
require 'goliath/rack/templates'
require File.join(File.dirname(__FILE__),"lib","sponsor_pay","request")

class ProcessRequest < Goliath::API
  use Goliath::Rack::Params
  use Goliath::Rack::JSONP
  use Goliath::Rack::Render 

  def response(env)
    params = ActiveSupport::HashWithIndifferentAccess.new(env)[:params] rescue {}
    http = SponsorPay::Request.new(params).get
    [200, {'X-SponsorPay' => 'Proxy','Content-Type' => 'application/json'}, http.response]
  end

end

class RenderIndex < Goliath::API
  include Goliath::Rack::Templates

  def response(env)
    [200,{},haml(:default)]
  end
end

class SponsorPayHandler < Goliath::API
  map "/", RenderIndex
  #TODO check the param2 in the documentation
  map "/:uid/:param2",ProcessRequest
end

runner = Goliath::Runner.new(ARGV, nil)
runner.api = SponsorPayHandler.new
runner.app = Goliath::Rack::Builder.build(SponsorPayHandler, runner.api)
runner.run
