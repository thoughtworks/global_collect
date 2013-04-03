# -*- encoding : utf-8 -*-
require 'spec_helper'

module TestResponseMethods
  def foobar;end
end

describe 'the api client' do
  it "should not accept an invalid environment" do
    lambda {
      GlobalCollect::ApiClient.new(:merchant_link, :foo, :ip_check)
    }.should raise_error(ArgumentError)
  end
  it "should not accept an invalid service" do
    lambda {
      GlobalCollect::ApiClient.new(:foo, :test, :ip_check)
    }.should raise_error(ArgumentError)
  end
  it "should not accept an invalid auth scheme" do
    lambda {
      GlobalCollect::ApiClient.new(:merchant_link, :test, :foo)
    }.should raise_error(ArgumentError)
  end
  
  it "should post to the correct url" do
    wire_up_response(:successful, :iowp, :v1)
    client = GlobalCollect::ApiClient.new(:merchant_link, :test, :ip_check)
    
    request = mock(
      :action => 'foo',
      :version => '1.0',
      :to_xml => "<XML></XML>",
      :suggested_response_mixins => []
    )
    response = client.make_request(request)
    response.success?.should == true
  end
  
  it "should mix in the proper mixins to the response by default" do
    wire_up_response(:successful, :iowp, :v1)
    client = GlobalCollect::ApiClient.new(:merchant_link, :test, :ip_check)
    
    request = mock(
      :action => 'foo',
      :version => '1.0',
      :to_xml => "<XML></XML>",
      :suggested_response_mixins => [TestResponseMethods]
    )
    response = client.make_request(request)
    lambda { response.foobar }.should_not raise_error
  end
  
  it "should not mix in anything if directed not to" do
    wire_up_response(:successful, :iowp, :v1)
    client = GlobalCollect::ApiClient.new(:merchant_link, :test, :ip_check)
    
    request = mock(
      :action => 'foo',
      :version => '1.0',
      :to_xml => "<XML></XML>",
      :suggested_response_mixins => [TestResponseMethods]
    )
    response = client.make_request(request, false)
    lambda { response.foobar }.should raise_error(NoMethodError)
  end
  
  it "should error on no response" do
    wire_up_response(:successful, :iowp, :v1)
    client = GlobalCollect::ApiClient.new(:merchant_link, :test, :ip_check)
    client.class.should_receive(:post).and_return(nil)
    request = mock(
      :action => 'foo',
      :version => '1.0',
      :to_xml => "<XML></XML>",
      :suggested_response_mixins => []
    )
    lambda { client.make_request(request) }.should raise_error(Exception, /No response/)
  end

  it "should error on a malformed response" do
    wire_up_response(:successful, :iowp, :v1)
    client = GlobalCollect::ApiClient.new(:merchant_link, :test, :ip_check)
    response = mock(:response, :body => "Foo bar", :code => "200", :parsed_response => {})
    client.class.should_receive(:post).and_return(response)

    request = mock(
      :action => 'foo',
      :version => '1.0',
      :to_xml => "<XML></XML>",
      :suggested_response_mixins => []
    )
    lambda { client.make_request(request) }.should raise_error(Exception, /Malformed/)
  end
end
