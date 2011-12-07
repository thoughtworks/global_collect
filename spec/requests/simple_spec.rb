require 'spec_helper'

class SimpleTestRequest < GlobalCollect::Requests::Simple
  def fields
    {
      "FOO" => ["N10", "R"]
    }
  end
end

class WrappedSimpleTestRequest < SimpleTestRequest
  def wrapper;"PARAPPA";end
end
describe "the simple request" do
  it "should build the right action" do
    request = SimpleTestRequest.new("WHAM",{"FOO" => "123"})
    xml = request.to_xml
    xml.should match_xpath("/XML/REQUEST/ACTION", "WHAM")
  end
  
  it "should build basic fields" do
    request = SimpleTestRequest.new("WHAM",{"FOO" => "123"})
    xml = request.to_xml
    xml.should match_xpath("/XML/REQUEST/PARAMS/FOO", "123")
  end
  
  it "should wrap the fields" do
    request = WrappedSimpleTestRequest.new("WHAM",{"FOO" => "123"})
    xml = request.to_xml
    xml.should match_xpath("/XML/REQUEST/PARAMS/PARAPPA/FOO", "123")
  end
  
  it "should validate fields" do
    request = SimpleTestRequest.new("WHAM",{"FOO" => "abc"})
    lambda { request.to_xml }.should raise_error(Exception, /Invalid field 'FOO'/)
  end
end
