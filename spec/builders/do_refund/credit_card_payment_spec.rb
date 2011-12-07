require 'spec_helper'

describe "the DO_REFUND credit card payment builder" do
  before(:each) do
    @node = Builder::XmlMarkup.new
  end
  it "should not build unknown keys" do
    @builder = GlobalCollect::Builders::DoRefund::CreditCardPayment.new('foo' => 'bar')
    @builder.build(@node)
    xml = @node.target!

    xml.should have_xpath("/PAYMENT")
    xml.should_not have_xpath("/PAYMENT/foo")
  end

  it "should build cc-specific keys" do
    fields = %w[
      PAYMENTPRODUCTID
      CREDITCARDNUMBER
      EXPIRYDATE
    ]
    @builder = GlobalCollect::Builders::DoRefund::CreditCardPayment.new(
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
