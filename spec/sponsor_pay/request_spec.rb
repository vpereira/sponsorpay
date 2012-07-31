require_relative '../spec_helper'


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
    
    describe ".get" do
      context "without EM" do
      	before do
        	Net::HTTP.stub!(:get).and_return(JSON.parse(File.open(File.join(File.dirname(__FILE__),'..','fixtures','response.json'),'r:utf-8').read))
      	end
      	it { @request.get.should be_a Hash }
      end
      context "with EM" do
	before do
		EM::HttpRequest.stub_chain(:new,:get).and_return(JSON.parse(File.open(File.join(File.dirname(__FILE__),'..','fixtures','response.json'),'r:utf-8').read))
	end
	it {
	  EM::run {
	  	@request.get.should be_a Hash
		EM::stop
	  }
	}
      end
    end
  end
  context "with specific uid" do
    before do
      @request = SponsorPay::Request.new(:uid=>"foo")
    end
    it { @request.params[:uid].should == "foo" }
  end
end
