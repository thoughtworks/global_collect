require 'spec_helper'

describe "the DO_PAYMENT recurring credit card online payment model" do
  it "should force CVVINDICATOR to '8' when not provided" do
    model = GlobalCollect::RequestModels::DoPayment::RecurringCreditCardOnlinePayment.new({
      "MERCHANTREFERENCE" => "aasfd",
      "ORDERID"           => "123",
      "PAYMENTPRODUCTID"  => "1",
      "AMOUNT"            => "123",
      "EFFORTID"          => "2",
      "CURRENCYCODE"      => "USD"
    })
    model['CVVINDICATOR'].should == "8"
  end
  it "should force CVVINDICATOR to '8' when something invalid is provided" do
    model = GlobalCollect::RequestModels::DoPayment::RecurringCreditCardOnlinePayment.new({
      "MERCHANTREFERENCE" => "aasfd",
      "ORDERID"           => "123",
      "PAYMENTPRODUCTID"  => "1",
      "AMOUNT"            => "123",
      "EFFORTID"          => "2",
      "CURRENCYCODE"      => "USD",
      "CVVINDICATOR"      => "11111111111111"
    })
    model['CVVINDICATOR'].should == "8"
  end
  it "should force CVVINDICATOR to '8' when something wrong is provided" do
    model = GlobalCollect::RequestModels::DoPayment::RecurringCreditCardOnlinePayment.new({
      "MERCHANTREFERENCE" => "aasfd",
      "ORDERID"           => "123",
      "PAYMENTPRODUCTID"  => "1",
      "AMOUNT"            => "123",
      "EFFORTID"          => "2",
      "CURRENCYCODE"      => "USD",
      "CVVINDICATOR"      => "1"
    })
    model['CVVINDICATOR'].should == "8"
  end
end
