# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "the DO_PAYMENT payment builder" do
  before(:each) do
    @node = Builder::XmlMarkup.new
  end
  it "should not build unknown keys" do
    @builder = GlobalCollect::Builders::DoPayment::Payment.new('foo' => 'bar')
    @builder.build(@node)
    xml = @node.target!

    xml.should have_xpath("/PAYMENT")
    xml.should_not have_xpath("/PAYMENT/foo")
  end

  it "should build known keys" do
    fields = %w[
      MERCHANTREFERENCE
      ORDERID
      EFFORTID
      PAYMENTPRODUCTID
      AMOUNT
      AMOUNTSIGN
      CURRENCYCODE
      HOSTEDINDICATOR
      RETURNURL
    ]
    @builder = GlobalCollect::Builders::DoRefund::Payment.new(
      fields.inject({}) {|m,k| m[k] = k; m }
    )
    @builder.build(@node)
    xml = @node.target!
    xml.should have_xpath("/PAYMENT")
    fields.each do |field|
      xml.should match_xpath("/PAYMENT/#{field}", field)
    end
  end
end
