require 'spec_helper'

describe "the payment report parser" do
  it "should parse" do
    file = File.open(support_path("55550141.wr1"), "r")
    data = GlobalCollect::LogParsing::PaymentReport::Parser.parse(file)

    data[:header].size.should == 1
    data[:header].first[:record_type].should == :file_header
    data[:header].first[:filename].should == '55550141'

    data[:batch_header].size.should == 1
    data[:batch_header].first[:record_type].should == :batch_header
    data[:batch_header].first[:merchant_id].should == 5555

    data[:trailer].size.should == 1
    data[:trailer].first[:record_type].should == :file_trailer
    data[:trailer].first[:filename].should == '55550141'

    data[:batch_trailer].size.should == 1
    data[:batch_trailer].first[:record_type].should == :batch_trailer
    data[:batch_trailer].first[:number_of_records].should == 443

    data[:information_records].size.should == 1
    data[:information_records].first[:total_amount_due].should == 211

    data[:data_records].size.should == 2
    data[:data_records].each do |r|
      r[:record_type].should == :settlement
      r[:record_category].should == :processed
      r[:payment][:payment_method].should == "CC"
      r[:order][:card_number].should == "************1234"
      r[:refund].values.each    {|v| v.should be_nil }
      r[:chargeback].values.each{|v| v.should be_nil }
    end
  end
end
