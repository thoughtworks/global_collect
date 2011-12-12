# -*- encoding : utf-8 -*-
require 'spec_helper'

describe GlobalCollect::Responses::DoPayment::ResponseMethods do
  before(:each) do
    @response = parse_canned_response(:successful, :do_payment, :v1)
    @response.extend(GlobalCollect::Responses::SuccessRow)
    @response.extend(GlobalCollect::Responses::DoPayment::ResponseMethods)
  end

  it "should see the methods" do
    @response.orderid.should == "9998990013"
  end
end
