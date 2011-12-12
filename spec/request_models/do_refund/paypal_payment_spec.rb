# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "the do_refund paypal payment model" do
  it "should set PAYMENTPRODUCTID to '1040' when not provided" do
    model = GlobalCollect::RequestModels::DoRefund::PaypalPayment.new(
      "ORDERID"               => "1234",
      "MERCHANTREFERENCE"     => "asdf"
    )
    model["PAYMENTPRODUCTID"].should == "1040"
  end

  it "should set PAYMENTPRODUCTID to '1040' when it is something invalid" do
    model = GlobalCollect::RequestModels::DoRefund::PaypalPayment.new(
      "ORDERID"               => "1234",
      "MERCHANTREFERENCE"     => "asdf",
      "PAYMENTPRODUCTID"      => "a"
    )
    model["PAYMENTPRODUCTID"].should == "1040"
  end

  it "should set PAYMENTPRODUCTID to '1040' when it is set to the wrong thing" do
    model = GlobalCollect::RequestModels::DoRefund::PaypalPayment.new(
      "ORDERID"               => "1234",
      "MERCHANTREFERENCE"     => "asdf",
      "PAYMENTPRODUCTID"      => "1"
    )
    model["PAYMENTPRODUCTID"].should == "1040"
  end
end
