# -*- encoding : utf-8 -*-
require 'spec_helper'

describe 'the GC module' do
  before(:each) do
    GlobalCollect.instance_variable_set(:@wire_logger, nil)
  end
  after(:each) do
    GlobalCollect.instance_variable_set(:@wire_logger, nil)
  end
  
  it "should default to version 1.0" do
    GlobalCollect.default_api_version.should == "1.0"
  end
  it "should error on an invalid environment" do
    GlobalCollect.environment = :foo
    lambda { GlobalCollect.merchant_link_client }.should raise_error(ArgumentError)
  end
  it "should error on an invalid auth scheme" do
    GlobalCollect.authentication_scheme = :foo
    lambda { GlobalCollect.merchant_link_client }.should raise_error(ArgumentError)
  end
  it "should return a merchant link client" do
    GlobalCollect.authentication_scheme = :ip_check
    GlobalCollect.environment = :test
    GlobalCollect.merchant_link_client.should_not be_nil
  end
  it "should write to a log file, if provided" do
    begin
      GlobalCollect.wire_log_file = File.join(File.dirname(__FILE__), "support", "test_log.log")
      GlobalCollect.wire_logger.debug("foo")
      log = File.open(GlobalCollect.wire_log_file, "r").read.strip.should include('foo')
    ensure
      FileUtils.rm_f(GlobalCollect.wire_log_file)
    end
  end
  
  it "should write to your logger if provided" do
    logger = mock(:logger)
    logger.should_receive(:debug).with("foo")
    GlobalCollect.wire_logger = logger
    GlobalCollect.wire_logger.debug("foo")
  end
end
