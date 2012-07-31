require_relative '../lib/sponsor_pay/request'
require 'yaml'
require 'uri'
require 'bundler'
Bundler.setup
Bundler.require
require 'goliath/test_helper'

RSpec.configure do |c| 
    c.include Goliath::TestHelper, :example_group => {
          :file_path => /spec\/integration/
	    }
end
