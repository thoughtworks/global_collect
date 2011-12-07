require 'spec_helper'

describe "the collection report parser" do
  it "should parse" do
    file = File.open(support_path("555555550145.mt1"), "r")
    data = GlobalCollect::LogParsing::CollectionReport::Parser.parse(file)
    data[:header].should_not be_nil
    data[:header][:account_id].should == 5555
    data[:header][:record_type].should == :file_header
    data[:header][:date_production].should == Date.ordinal(2010, 145)
    data[:header][:period_to].should       == Date.ordinal(2010, 145)
    data[:header][:period_from].should     == Date.ordinal(2010, 145)

    data[:trailer].should_not be_nil
    data[:trailer][:account_id].should == 5555
    data[:trailer][:record_type].should == :file_trailer
    data[:trailer][:number_of_records].should == 3
    data[:trailer][:date_production].should == Date.ordinal(2010, 145)
    data[:trailer][:period_to].should       == Date.ordinal(2010, 145)
    data[:trailer][:period_from].should     == Date.ordinal(2010, 145) 

    data[:data_records].should_not be_nil
    data[:data_records].size.should == 1
    data_record = data[:data_records].first
    data_record[:report_date_from      ].should == Date.ordinal(2010, 145)
    data_record[:amount_paid           ].should == 2384211
    data_record[:report_date_to        ].should == Date.ordinal(2010, 145)
    data_record[:amount_paid_sign      ].should == nil
    data_record[:currency_due          ].should == "USD"
    data_record[:exchange_rate         ].should == 1.0
    data_record[:match_date            ].should == Date.ordinal(2010, 145)
    data_record[:record_type           ].should == :data_record
    data_record[:amount_due            ].should == 2384211
    data_record[:rate_units            ].should == 1
    data_record[:report_year           ].should == 2010
    data_record[:amount_due_sign       ].should == nil
    data_record[:merchant_id           ].should == 5555
    data_record[:number_of_transactions].should == 1137
    data_record[:report_serial_number  ].should == 1
    data_record[:currency_paid         ].should == "USD"
  end
end
