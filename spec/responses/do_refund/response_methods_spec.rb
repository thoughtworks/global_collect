# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "the do refund response methods" do
  before(:each) do
    @response = parse_canned_response(:successful, :do_refund, :v1)
    @response.extend(GlobalCollect::Responses::SuccessRow)
    @response.extend(GlobalCollect::Responses::DoRefund::ResponseMethods)
  end

  it "should see the methods" do
    @response.status_id.should == "800"
    @response.payment_status.should_not be_nil
    @response.payment_status.code.should be(800)
  end
end
