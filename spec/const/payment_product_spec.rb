# -*- encoding : utf-8 -*-
require 'spec_helper'

describe 'the payment product constants' do
  it "should fetch a product by sym" do
    visa = GlobalCollect::Const::PaymentProduct.from_sym(:visa)
    visa.should_not be_nil
    visa.symbol.should be(:visa)
    visa.code.should be(1)
  end
  
  it "should fetch a product by code" do
    visa = GlobalCollect::Const::PaymentProduct.from_code("1")
    visa.should_not be_nil
    visa.symbol.should be(:visa)
  end
end
