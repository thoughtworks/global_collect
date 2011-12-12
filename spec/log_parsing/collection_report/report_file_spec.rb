# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "the collection report file" do
  it "should sort out the metadata from the file name" do
    report = GlobalCollect::LogParsing::CollectionReport::ReportFile.new("555555550145.mt1")
    report.account_id.should == "5555"
    report.master_account_id.should == "5555"
    report.date.should == Date.ordinal(2011, 145)
    report.environment.should == :production
  end

  it "should parse" do
    report = GlobalCollect::LogParsing::CollectionReport::ReportFile.new(support_path("555555550145.mt1"))
    report.parse
    report.data.should_not be_blank
  end
end
