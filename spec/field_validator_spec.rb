# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "the model validator" do
  it "should accept nil when the field is not required" do
    GlobalCollect::FieldValidator.new("D", "O").validate(nil).should be_true
    GlobalCollect::FieldValidator.new("N1", "O").validate(nil).should be_true
    GlobalCollect::FieldValidator.new("AN1", "O").validate(nil).should be_true
  end
  
  it "should validate good dates" do
    validator = GlobalCollect::FieldValidator.new("D", "R")
    validator.to_sym.should == :datetime
    # random good dates from the spec
    validator.validate("20070830120000").should be_true
    validator.validate("20010101000000").should be_true
    validator.validate("19990413012344").should be_true
  end

  it "should not validate bad dates" do
    validator = GlobalCollect::FieldValidator.new("D", "R")
    validator.to_sym.should == :datetime
    # too short
    validator.validate("1111").should be_false
    # invalid second
    validator.validate("20100101000099").should be_false
    # invalid minute
    validator.validate("20100101009900").should be_false
    # invalid hour
    validator.validate("20100101990000").should be_false
    # invalid day
    validator.validate("20100199000000").should be_false
    # invalid month
    validator.validate("20109901000000").should be_false
    # bad prefix
    validator.validate("a20100101123456").should be_false
    # bad suffix
    validator.validate("20100101123456a").should be_false
  end
  
  it "should validate good alphanumerics" do
    validator = GlobalCollect::FieldValidator.new("AN4", "R")
    validator.to_sym.should == :alphanumeric
    validator.validate("a1b2").should be_true
    validator.validate("A1B2").should be_true
    validator.validate("A1b2").should be_true
    validator.validate("aaa").should be_true
    validator.validate("111").should be_true
    validator.validate("a b2").should be_true
    validator.validate("A-B2").should be_true
    validator.validate("A1b2").should be_true
    validator.validate("").should be_true
    validator.validate("    ").should be_true
  end
  
  it "should not validate bad alphanumerics" do
    validator = GlobalCollect::FieldValidator.new("AN4", "R")
    validator.to_sym.should == :alphanumeric
    # too long
    validator.validate("aaa213123123123").should be_false
  end
  
  it "should validate good numerics" do
    validator = GlobalCollect::FieldValidator.new("N4", "R")
    validator.to_sym.should == :numeric
    validator.validate("1").should be_true
    validator.validate("12").should be_true
    validator.validate("123").should be_true
    validator.validate("1234").should be_true
  end
  
  it "should not validate bad numerics" do
    validator = GlobalCollect::FieldValidator.new("N4", "R")
    validator.to_sym.should == :numeric
    validator.validate("").should be_false
    validator.validate("a12").should be_false
    validator.validate("a").should be_false
    validator.validate(" ").should be_false
  end 
end
