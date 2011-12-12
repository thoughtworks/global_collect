# -*- encoding : utf-8 -*-
require 'spec_helper'
class AirlineDataBuilder
  def initialize(data);end
  def build(node)
    node.tag!("AIRLINEDATA") do |airline_node|
      airline_node.tag!("FOO")
    end
  end
end
class AirlineDataModel
  def validate;true;end
  def suggested_response_mixins;[];end
end
describe "the insert order with payment request" do
  before(:each) do
    @order = GlobalCollect::RequestModels::InsertOrderWithPayment::Order.new(
      "ORDERID"                        => "1234567890",
      "AMOUNT"                         => "1234",
      "CURRENCYCODE"                   => "USD",
      "LANGUAGECODE"                   => "en",
      "COUNTRYCODE"                    => "US",
      "MERCHANTREFERENCE"              => "ASDASDASD"
    )
    @payment = GlobalCollect::RequestModels::InsertOrderWithPayment::Payment.new(
      "PAYMENTPRODUCTID" => "1",
      "AMOUNT"           => "1234",
      "CURRENCYCODE"     => "USD",
      "LANGUAGECODE"     => "en",
      "COUNTRYCODE"      => "US"
    )
    @request = GlobalCollect::Requests::InsertOrderWithPayment.new(
      [ @order, GlobalCollect::Builders::InsertOrderWithPayment::Order ],
      [ @payment, GlobalCollect::Builders::InsertOrderWithPayment::Payment ]
    )
  end
  it "should have the correct action" do
    xml = @request.to_xml
    xml.should match_xpath("/XML/REQUEST/ACTION", "INSERT_ORDERWITHPAYMENT")
  end

  it "should have a payment node" do
    xml = @request.to_xml
    xml.should have_xpath("/XML/REQUEST/PARAMS/PAYMENT")
  end

  it "should have an order node" do
    xml = @request.to_xml
    xml.should have_xpath("/XML/REQUEST/PARAMS/ORDER")
  end

  it "should allow extra builders, like AIRLINEDATA" do
    @request = GlobalCollect::Requests::InsertOrderWithPayment.new(
      [ @order, GlobalCollect::Builders::InsertOrderWithPayment::Order ],
      [ @payment, GlobalCollect::Builders::InsertOrderWithPayment::Payment ],
      [ AirlineDataModel.new, AirlineDataBuilder ]
    )
    xml = @request.to_xml
    xml.should have_xpath("/XML/REQUEST/PARAMS/AIRLINEDATA/FOO")
  end
end
