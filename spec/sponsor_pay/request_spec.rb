require_relative '../spec_helper'
require 'uri'

describe SponsorPay::Request do
  context "default values" do
    before do
      @request = SponsorPay::Request.new
    end
    it { @request.should_not be_nil }
    it { @request.params.keys.should_not be_empty }
    it { @request.params.keys.should == [:appid,:format,:device_id,:locale,:ip,:offer_types,:uid,:timestamp] }
    it { @request.query_string.should be_a String }
    it { @request.hashkey.should match /\b([a-f0-9]{40})\b/ }
    
    describe ".uri" do
      it { lambda { URI.parse(@request.uri) }.should_not raise_error }
      it { URI.parse(@request.uri).should_not be_nil }
    end
  end
  context "with specific uid" do
    before do
      @request = SponsorPay::Request.new(:uid=>"foo")
    end
    it { @request.params[:uid].should == "foo" }
  end
end