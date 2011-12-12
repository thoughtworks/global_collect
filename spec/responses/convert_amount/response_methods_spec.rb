# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "the convert amount response methods" do
  before(:each) do
    @response = parse_canned_response(:successful, :convert_amount, :v1)
    @response.extend(GlobalCollect::Responses::SuccessRow)
    @response.extend(GlobalCollect::Responses::ConvertAmount::ResponseMethods)
  end

  it "should see the methods" do
    @response.converted_amount.should == "1174"
  end
end
