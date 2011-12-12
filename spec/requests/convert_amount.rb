# -*- encoding : utf-8 -*-
require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "the convert amount request" do
  before(:each) do
    @request = GlobalCollect::Requests::ConvertAmount.new(
      "100",
      "USD",
      "GBP"
    )
  end
  it "should build the right action" do
    xml = @request.to_xml
    xml.should match_xpath("/XML/REQUEST/ACTION", "CONVERT_AMOUNT")
  end
  
  it "should build basic fields" do
    xml = @request.to_xml
    xml.should match_xpath("/XML/REQUEST/PARAMS/GENERAL/AMOUNT", "100")
    xml.should match_xpath("/XML/REQUEST/PARAMS/GENERAL/SOURCECURRENCYCODE", "USD")
    xml.should match_xpath("/XML/REQUEST/PARAMS/GENERAL/TARGETCURRENCYCODE", "GBP")
  end
  
  it "should wrap the fields" do
    xml = @request.to_xml
    xml.should have_xpath("/XML/REQUEST/PARAMS/GENERAL")
  end
  
  it "should suggest the correct mixins" do
    @request.suggested_response_mixins.should == [
      GlobalCollect::Responses::SuccessRow,
      GlobalCollect::Responses::ConvertAmount::ResponseMethods
    ]
  end
end
