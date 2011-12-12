# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "the hosted merchant link payment response methods" do
  before(:each) do
    @response = parse_canned_response(:successful, :hosted_iowp, :v1)
    @response.extend(GlobalCollect::Responses::SuccessRow)
    @response.extend(GlobalCollect::Responses::InsertOrderWithPayment::HostedMerchantLinkPaymentResponseMethods)
  end

  it "should see the methods" do
    @response.form_method.should == "GET"
  end
end
