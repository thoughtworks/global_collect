# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "the credit card online payment response methods" do
  before(:each) do
    @response = parse_canned_response(:successful, :iowp, :v1)
    @response.extend(GlobalCollect::Responses::SuccessRow)
    @response.extend(GlobalCollect::Responses::InsertOrderWithPayment::CreditCardOnlinePaymentResponseMethods)
  end

  it "should see the methods" do
    @response.order_id.should == "42"
  end
end
