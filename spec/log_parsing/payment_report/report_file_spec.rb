# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "the payment report file" do
  it "should sort out the metadata from the file name (prod)" do
    report = GlobalCollect::LogParsing::PaymentReport::ReportFile.new("55550141.wr1")
    report.account_id.should == "5555"
    report.date.should == Date.ordinal(2011, 141)
    report.environment.should == :production
  end

  it "should sort out the metadata from the file name (test)" do
    report = GlobalCollect::LogParsing::PaymentReport::ReportFile.new("55550141.wrt")
    report.account_id.should == "5555"
    report.date.should == Date.ordinal(2011, 141)
    report.environment.should == :test
  end

  it "should parse" do
    report = GlobalCollect::LogParsing::PaymentReport::ReportFile.new(support_path("55550141.wr1"))
    report.parse
    report.data.should_not be_blank
  end
end
