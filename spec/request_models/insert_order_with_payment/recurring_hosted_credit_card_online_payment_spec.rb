# -*- encoding : utf-8 -*-
require 'spec_helper'

describe GlobalCollect::RequestModels::InsertOrderWithPayment::RecurringHostedCreditCardOnlinePayment do
  it "should set CVVINDICATOR to '8' when not provided" do
    model = GlobalCollect::RequestModels::InsertOrderWithPayment::RecurringHostedCreditCardOnlinePayment.new(
      "PAYMENTPRODUCTID" => "1",
      "AMOUNT"           => "1",
      "CURRENCYCODE"     => "USD",
      "LANGUAGECODE"     => "en",
      "COUNTRYCODE"      => "US"
    )
    model["CVVINDICATOR"].should == "8"
  end

  it "should set CVVINDICATOR to '8' when it is set to something invalid" do
    model = GlobalCollect::RequestModels::InsertOrderWithPayment::RecurringHostedCreditCardOnlinePayment.new(
      "PAYMENTPRODUCTID" => "1",
      "AMOUNT"           => "1",
      "CURRENCYCODE"     => "USD",
      "LANGUAGECODE"     => "en",
      "COUNTRYCODE"      => "US",
      "CVVINDICATOR"     => "2123123213"
    )
    model["CVVINDICATOR"].should == "8"
  end

  it "should set CVVINDICATOR to '8' when it is set to the wrong thing" do
    model = GlobalCollect::RequestModels::InsertOrderWithPayment::RecurringHostedCreditCardOnlinePayment.new(
      "PAYMENTPRODUCTID" => "1",
      "AMOUNT"           => "1",
      "CURRENCYCODE"     => "USD",
      "LANGUAGECODE"     => "en",
      "COUNTRYCODE"      => "US",
      "CVVINDICATOR"     => "1"
    )
    model["CVVINDICATOR"].should == "8"
  end
end
