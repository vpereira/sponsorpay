require 'spec_helper'

describe SponsorPay::Request do
  context "default values" do
    before do
      @request = SponsorPay::Request.new
    end
    it { @request.should_not be_nil }
    it { @request.params.keys.should_not be_empty }
    it { @request.params.keys.should == [:appid,:format,:device_id,:locale,:ip,:offer_types,:uid,:timestamp] }
  end
  context "with specific uid" do
    before do
      @request = SponsorPay::Request.new(:uid=>"foo")
    end
    it { @request.params[:uid].should == "foo" }
  end
end