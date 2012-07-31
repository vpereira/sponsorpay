#!/usr/bin/env ruby

# Rewrites and proxies requests to a third-party API, with HTTP basic authentication.

require "bundler/setup"
require 'bundler'
Bundler.setup
Bundler.require
require 'active_support/core_ext/hash/keys'
require 'em-synchrony/em-http'
require 'goliath/rack/templates'
require File.join(File.dirname(__FILE__),"lib","sponsor_pay","request")

class ProcessRequest < Goliath::API
  use Goliath::Rack::Params
  use Goliath::Rack::JSONP
  use Goliath::Rack::Render 
  include Goliath::Rack::Templates

  def response(env)
    params = env["params"] rescue {}
    params.symbolize_keys!
    http = SponsorPay::Request.new(params).get

    if http.response.empty? 
    	[200, {'X-SponsorPay' => 'Proxy','Content-Type' => 'text/html'}, haml(:notfound)]
    else
    	[200, {'X-SponsorPay' => 'Proxy','Content-Type' => 'text/html'}, haml(:answer,:locals=>{:response=>JSON.parse(http.response)})]
    end
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
  post "/process",ProcessRequest
end

if __FILE__ == $0
  runner = Goliath::Runner.new(ARGV, nil)
  runner.api = SponsorPayHandler.new
  runner.app = Goliath::Rack::Builder.build(SponsorPayHandler, runner.api)
  runner.run
end
