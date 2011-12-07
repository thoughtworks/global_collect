require 'spec_helper'

describe "the DO_PAYMENT recurring payment model" do
  it "should not allow blank EFFORTID" do
    GlobalCollect::RequestModels::DoPayment::RecurringPayment.new({
      "MERCHANTREFERENCE" => "aasfd",
      "ORDERID"           => "123",
      "PAYMENTPRODUCTID"  => "1",
      "AMOUNT"            => "123",
      "CURRENCYCODE"      => "USD"
    }).validate.should be_false
  end
  it "should allow blank PAYMENTPRODUCTID" do
    GlobalCollect::RequestModels::DoPayment::RecurringPayment.new({
      "MERCHANTREFERENCE" => "aasfd",
      "ORDERID"           => "123",
      "EFFORTID"          => "2",
      "AMOUNT"            => "123",
      "CURRENCYCODE"      => "USD"
    }).validate.should be_true
  end
end
