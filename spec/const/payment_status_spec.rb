# -*- encoding : utf-8 -*-
require 'spec_helper'

describe 'the payment status constants' do
  it "should fetch a status by name" do
    status = GlobalCollect::Const::PaymentStatus.from_name("READY")
    status.should_not be_nil
    status.code.should be(800)
  end
  
  it "should fetch a product by code" do
    status = GlobalCollect::Const::PaymentStatus.from_code(800)
    status.should_not be_nil
    status.name.should == "READY"
  end
end
