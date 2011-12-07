require 'spec_helper'

describe GlobalCollect::RequestModels::InsertOrderWithPayment::RecurringOrder do
  it "should set ORDERTYPE to '4' when not provided" do
    model = GlobalCollect::RequestModels::InsertOrderWithPayment::RecurringOrder.new(
      "ORDERID"      => "1",
      "AMOUNT"       => "1",
      "CURRENCYCODE" => "USD",
      "LANGUAGECODE" => "en",
      "COUNTRYCODE"  => "US"
    )
    model["ORDERTYPE"].should == "4"
  end

  it "should set ORDERTYPE to '4' when it is set to something invalid" do
    model = GlobalCollect::RequestModels::InsertOrderWithPayment::RecurringOrder.new(
      "ORDERID"      => "1",
      "ORDERTYPE"    => "1123",
      "AMOUNT"       => "1",
      "CURRENCYCODE" => "USD",
      "LANGUAGECODE" => "en",
      "COUNTRYCODE"  => "US"
    )
    model["ORDERTYPE"].should == "4"
  end

  it "should set ORDERTYPE to '4' when it is set to the wrong thing" do
    model = GlobalCollect::RequestModels::InsertOrderWithPayment::RecurringOrder.new(
      "ORDERID"      => "1",
      "ORDERTYPE"    => "1",
      "AMOUNT"       => "1",
      "CURRENCYCODE" => "USD",
      "LANGUAGECODE" => "en",
      "COUNTRYCODE"  => "US"
    )
    model["ORDERTYPE"].should == "4"
  end

  it "should set STEPMONTH to '120' when not provided" do
    model = GlobalCollect::RequestModels::InsertOrderWithPayment::RecurringOrder.new(
      "ORDERID"      => "1",
      "AMOUNT"       => "1",
      "CURRENCYCODE" => "USD",
      "LANGUAGECODE" => "en",
      "COUNTRYCODE"  => "US"
    )
    model["STEPMONTH"].should == "120"
  end

  it "should not overwrite STEPMONTH whe provided" do
    model = GlobalCollect::RequestModels::InsertOrderWithPayment::RecurringOrder.new(
      "ORDERID"      => "1",
      "AMOUNT"       => "1",
      "CURRENCYCODE" => "USD",
      "LANGUAGECODE" => "en",
      "COUNTRYCODE"  => "US",
      "STEPMONTH"    => "1"
    )
    model["STEPMONTH"].should == "1"
  end
end
