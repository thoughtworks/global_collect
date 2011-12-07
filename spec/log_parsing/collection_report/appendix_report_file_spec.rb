require 'spec_helper'

describe "the appendix to the collection report file" do
  it "should sort out the metadata from the file name" do
    report = GlobalCollect::LogParsing::CollectionReport::AppendixReportFile.new("555520100602.csv")
    report.account_id.should == "5555"
    report.date.should == Date.strptime("20100602", "%Y%m%d")
    report.environment.should == :production
  end

  it "should parse" do
    report = GlobalCollect::LogParsing::CollectionReport::AppendixReportFile.new(support_path("555520100602.csv"))
    report.parse
    report.data.should_not be_blank
    report.data.should == {
        :data_records => [
           {
                                 :order_currency => "USD",
                             :merchant_reference => "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                                   :order_amount => 41.05,
                                 :invoice_number => "",
                                 :payment_method => :credit_card,
                                    :customer_id => "",
                                    :merchant_id => 5555,
                            :credit_card_company => "ECMC",
                                   :currency_due => "USD",
                         :filename_data_delivery => "a0110147.pg1",
                                :record_category => "+",
                         :cross_border_indicator => "N",
                                     :amount_due => 41.05,
                                   :payment_type => :payment,
                                       :date_due => Date.strptime("20100602", "%Y%m%d"),
                                    :record_type => :settlement,
                :globalcollect_payment_reference => "206807294137"
            },
            {
                                 :order_currency => "USD",
                             :merchant_reference => "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb",
                                   :order_amount => 88.99,
                                 :invoice_number => "",
                                 :payment_method => :credit_card,
                                    :customer_id => "",
                                    :merchant_id => 5555,
                            :credit_card_company => "VISA",
                                   :currency_due => "USD",
                         :filename_data_delivery => "a0110147.pg1",
                                :record_category => "+",
                         :cross_border_indicator => "N",
                                     :amount_due => 88.99,
                                   :payment_type => :payment,
                                       :date_due => Date.strptime("20100602", "%Y%m%d"),
                                    :record_type => :settlement,
                :globalcollect_payment_reference => "206807294138"
            },
            {
                                 :order_currency => "USD",
                             :merchant_reference => "cccccccccccccccccccccccccccccc",
                                   :order_amount => -24.5,
                                 :invoice_number => "",
                                 :payment_method => :credit_card,
                                    :customer_id => "",
                                    :merchant_id => 5555,
                            :credit_card_company => "VISA",
                                   :currency_due => "USD",
                         :filename_data_delivery => "a0110147.rg1",
                                :record_category => "-",
                         :cross_border_indicator => "N",
                                     :amount_due => -24.5,
                                   :payment_type => :refund_or_reversal,
                                       :date_due => Date.strptime("20100602", "%Y%m%d"),
                                    :record_type => :refund,
                :globalcollect_payment_reference => "206806008113"
            },
            {
                                 :order_currency => "USD",
                             :merchant_reference => "dddddddddddddddddddddddddddddd",
                                   :order_amount => -77.83,
                                 :invoice_number => "",
                                 :payment_method => :credit_card,
                                    :customer_id => "",
                                    :merchant_id => 5555,
                            :credit_card_company => "ECMC",
                                   :currency_due => "USD",
                         :filename_data_delivery => "a0110147.rg1",
                                :record_category => "-",
                         :cross_border_indicator => "N",
                                     :amount_due => -77.83,
                                   :payment_type => :refund_or_reversal,
                                       :date_due => Date.strptime("20100602", "%Y%m%d"),
                                    :record_type => :refund,
                :globalcollect_payment_reference => "206806008114"
            }
        ]
    }
  end
end
