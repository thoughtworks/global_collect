require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper')

describe "the do refund response methods" do
  before(:each) do
    @hash = Crack::XML.parse(load_canned_response('successful_do_refund_response.xml'))
    @response = GlobalCollect::Responses::Base.new(@hash)
    @response.extend(GlobalCollect::Responses::SuccessRow)
    @response.extend(GlobalCollect::Responses::DoRefund::ResponseMethods)
  end

  it "should see the methods" do
    @response.status_id.should == "800"
    @response.payment_status.should_not be_nil
    @response.payment_status.code.should be(800)
  end
end