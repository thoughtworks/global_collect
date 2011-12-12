# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "the base response" do
  describe "on a successful response" do
    before(:each) do
      @response = parse_canned_response(:successful, :iowp, :v1)
    end
    
    it "should provide the success data hash" do
      @response.extend(GlobalCollect::Responses::SuccessRow)
      @response.row.should be_a Hash
      @response.row.should_not be_blank
    end
  end
  
  describe "on an unsuccessful response" do
    before(:each) do
      @response = parse_canned_response(:unsuccessful, :iowp, :v1)
    end

    it "should not provide the success data hash" do
      @response.extend(GlobalCollect::Responses::SuccessRow)
      @response.row.should be_nil
    end
  end
end
