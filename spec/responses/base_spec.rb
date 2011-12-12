# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "the base response" do
  describe "on a successful response" do
    before(:each) do
      @response = parse_canned_response(:successful, :iowp, :v1)
    end

    it "should identify success" do
      @response.success?.should == true
    end

    it "should identify meta fields correctly" do
      @response.request_id.should == "3000852"
      @response.response_datetime.should == Time.parse("Fri Apr 09 02:03:09 2010")
    end

    it "should give you the raw hash to access" do
      @response.hash.should_not be_blank
    end

    it "should not provide the errors" do
      @response.errors.should be_empty
    end

    it "should provide the raw and parsed response" do
      @response.response_hash.should be_a(Hash)
      xml = @response.raw_response
      xml.should have_xpath("/XML/REQUEST/META")
    end
  end

  describe "on an unsuccessful response" do
    before(:each) do
      @response = parse_canned_response(:unsuccessful, :iowp, :v1)
    end

    it "should identify success" do
      @response.success?.should == false
    end

    it "should identify meta fields correctly" do
      @response.request_id.should == "3000854"
      @response.response_datetime.should == Time.parse("Fri Apr 09 02:03:28 2010")
    end

    it "should provide the errors" do
      @response.errors.should_not be_empty
      @response.errors.first.code.should_not be_blank
      @response.errors.first.message.should_not be_blank
    end

    it "should provide the raw and parsed response" do
      @response.response_hash.should be_a(Hash)
      xml = @response.raw_response
      xml.should have_xpath("/XML/REQUEST/META")
    end
  end
end
