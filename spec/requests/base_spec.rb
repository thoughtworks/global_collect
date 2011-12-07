require 'spec_helper'

describe "the base request" do
  before(:all) do
    GlobalCollect.merchant_id = 666
    GlobalCollect.authentication_scheme = :ip_check
    GlobalCollect.ip_address = '0.0.0.0'
    GlobalCollect::default_api_version = "2.0"
  end

  it "should have the correct wrapping xml elements" do
    request = GlobalCollect::Requests::Base.new("FOO_ACTION")
    xml = request.to_xml do |params_node|
    end
    xml.should have_xpath("/XML/REQUEST")
  end

  it "should render the action" do
    request = GlobalCollect::Requests::Base.new("FOO_ACTION")
    xml = request.to_xml do |params_node|; end
    xml.should match_xpath("/XML/REQUEST/ACTION", "FOO_ACTION")
  end

  it "should render contents" do
    request = GlobalCollect::Requests::Base.new("FOO_ACTION")
    xml = request.to_xml do |params_node|
      params_node.tag!("FOO_NODE")
    end
    xml.should have_xpath("/XML/REQUEST/PARAMS/FOO_NODE")
  end

  it "should have the correct meta fields" do
    request = GlobalCollect::Requests::Base.new("FOO_ACTION")

    xml = request.to_xml do |params_node|; end
    xml.should match_xpath("/XML/REQUEST/META/IPADDRESS", "0.0.0.0")
    xml.should match_xpath("/XML/REQUEST/META/VERSION", "2.0")
    xml.should match_xpath("/XML/REQUEST/META/MERCHANTID", "666")
  end
end
