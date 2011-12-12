# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "the v2 get order status response methods" do
  before(:each) do
    @response = parse_canned_response(:successful, :get_order_status, :v2)
    @response.extend(GlobalCollect::Responses::GetOrderStatus::V2ResponseMethods)
  end

  it "should give the statuses" do
    @response.statuses.should_not be_nil
    @response.statuses.size.should be(1)
    @response.statuses.first.should_not be_nil
  end

  it "should have responses with helper accessor methods" do
    @response.statuses.first.order_id.should == "53"
  end

  it "should have responses with status lookup methods" do
    @response.statuses.first.payment_status.code.should be(100)
  end

  it "should have responses with error helper methods" do
    @response.statuses.first.errors.should_not be_nil
    @response.statuses.first.errors.size.should be(2)
    @response.statuses.first.errors.first.code.should be(20001000)
  end
end
