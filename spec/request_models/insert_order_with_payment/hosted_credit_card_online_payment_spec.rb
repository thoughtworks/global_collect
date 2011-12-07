require 'spec_helper'

describe "the hosted credit card online payment model" do
  it "should set HOSTEDINDICATOR to '1' when not provided" do
    model = GlobalCollect::RequestModels::InsertOrderWithPayment::HostedCreditCardOnlinePayment.new(
      "PAYMENTPRODUCTID" => "1",
      "AMOUNT"           => "1",
      "CURRENCYCODE"     => "USD",
      "LANGUAGECODE"     => "en",
      "COUNTRYCODE"      => "US"
    )
    model["HOSTEDINDICATOR"].should == "1"
  end
  
  it "should set HOSTEDINDICATOR to '1' when it is set to something invalid" do
    model = GlobalCollect::RequestModels::InsertOrderWithPayment::HostedCreditCardOnlinePayment.new(
      "PAYMENTPRODUCTID" => "1",
      "AMOUNT"           => "1",
      "CURRENCYCODE"     => "USD",
      "LANGUAGECODE"     => "en",
      "COUNTRYCODE"      => "US",
      "HOSTEDINDICATOR"  => "2123123213"
    )
    model["HOSTEDINDICATOR"].should == "1"
  end
  
  it "should set HOSTEDINDICATOR to '1' when it is set to the wrong thing" do
    model = GlobalCollect::RequestModels::InsertOrderWithPayment::HostedCreditCardOnlinePayment.new(
      "PAYMENTPRODUCTID" => "1",
      "AMOUNT"           => "1",
      "CURRENCYCODE"     => "USD",
      "LANGUAGECODE"     => "en",
      "COUNTRYCODE"      => "US",
      "HOSTEDINDICATOR"  => "0"
    )
    model["HOSTEDINDICATOR"].should == "1"
  end
end
