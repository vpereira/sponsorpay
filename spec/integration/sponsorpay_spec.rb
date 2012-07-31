require 'spec_helper'
require_relative '../../sponsorpay'
describe SponsorPay do

  it "should get a 200 code" do
    with_api(RenderIndex,{:layout_engine=>:haml}) do
	    get_request(:path=>"/") do |c|
	      c.response.should =~ %r{<h1>SEND FORM</h1>}
	    end
    end
  end
end
