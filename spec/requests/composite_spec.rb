# -*- encoding : utf-8 -*-
require 'spec_helper'

class TestModel
  attr_reader :validate
  def initialize(valid);@validate=valid;end
  def suggested_response_mixins;[];end
  def errors; {}; end
end
class TestModelBuilder
  def initialize(model);end
  def build(node)
    node.tag!("FOO_NODE")
  end
end

module MixinTest
end
class TestMixinModel < TestModel
  def suggested_response_mixins
    [MixinTest, MixinTest]
  end
end

describe "the composite request" do
  it "should build properly from model-builder pairs" do
    pair = [TestModel.new(true), TestModelBuilder]
    request = GlobalCollect::Requests::Composite.new("FOO_ACTION", [pair])
    xml = request.to_xml
    xml.should have_xpath("/XML/REQUEST/PARAMS/FOO_NODE")
  end
  
  it "should fail on an invalid model" do
    pair = [TestModel.new(false), TestModelBuilder]
    request = GlobalCollect::Requests::Composite.new("FOO_ACTION", [pair])
    lambda { request.to_xml }.should raise_error(Exception, /Invalid model/)
  end
  
  it "should fail on unpaired models and builders" do
    pair = [TestModel.new(false)]
    lambda { GlobalCollect::Requests::Composite.new("FOO_ACTION", [pair]) }.should raise_error(ArgumentError, /pairs/)
  end
  
  it "should not suggest duplicate mixins" do
    pair = [TestMixinModel.new(true), TestModelBuilder]
    request = GlobalCollect::Requests::Composite.new("FOO_ACTION", [pair])
    request.suggested_response_mixins.size.should == 1
  end
end
