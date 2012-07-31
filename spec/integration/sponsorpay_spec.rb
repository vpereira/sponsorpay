require 'spec_helper'
require_relative '../../sponsorpay'
describe SponsorPay do

  it "should get the index page" do
    with_api(RenderIndex,{:layout_engine=>:haml}) do
	    get_request(:path=>"/") do |c|
	      c.response.should =~ %r{<h1>SEND FORM</h1>}
	    end
    end
  end
  describe ProcessRequest do
    before do
      @my_mock = mock EM::HttpClient
      @my_mock.stub!(:response).and_return(JSON.parse(File.open(File.join(File.dirname(__FILE__),'..','fixtures','response.json'),'r:utf-8').read))
      SponsorPay::Request.stub_chain(:new,:get).and_return(@my_mock)
    end
    let(:err) { Proc.new { fail "API request failed" } }
    it "should post the form" do
      with_api(ProcessRequest,{}) do
        post_request({:uid=>"foo",:pub0=>"bar"},err) do |r|
          r.should_not be_nil
        end
      end
    end
  end
end
