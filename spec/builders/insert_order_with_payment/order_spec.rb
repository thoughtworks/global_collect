# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "the IOWP order builder" do
  before(:each) do
    @node = Builder::XmlMarkup.new
  end
  it "should not build unknown keys" do
    @builder = GlobalCollect::Builders::InsertOrderWithPayment::Order.new('foo' => 'bar')
    @builder.build(@node)
    xml = @node.target!
    
    xml.should have_xpath("/ORDER")
    xml.should_not have_xpath("/ORDER/foo")
  end
  
  it "should build known keys" do
    fields = %w[
      ORDERID
      ORDERTYPE
      AMOUNT
      AMOUNTSIGN
      CURRENCYCODE
      LANGUAGECODE
      COUNTRYCODE        
      OVERWRITEPAYMENTREFERNCE
      IPADDRESSCUSTOMER
      CUSTOMERID
      MANDATE
      TITLE
      FIRSTNAME
      PREFIXSURNAME
      SURNAME
      STREET
      HOUSENUMBER
      ADDITIONALADDRESSINFO
      ZIP
      CITY
      STATE
      SHIPPINGTITLE
      SHIPPINGFIRSTNAME
      SHIPPINGPREFIXSURNAME
      SHIPPINGSURNAME
      SHIPPINGSTREET
      SHIPPINGHOUSENUMBER
      SHIPPINGADDITIONALADDRESSINFO
      SHIPPINGZIP
      SHIPPINGCITY
      SHIPPINGSTATE
      SHIPPINGCOUNTRYCODE
      MERCHANTREFERENCE
      DESCRIPTOR
      RESELLERID
      EMAIL
      EMAILTYPEINDICATOR
      COMPANYNAME
      COMPANYDATA
      SEX
      VATNUMBER
      PHONENUMBER
      FAXNUMBER
      INVOICENUMBER
      INVOICETYPE
      INVOICEDATE
      INVOICECLASS
      ORDERDATE
      BIRTHDATE
      TEXTQUALIFIER1
      TEXTQUALIFIER2
      TEXTQUALIFIER3
      ADDITIONALDATA
      STARTDATE
      ENDDATE
      NUMBEROFPAYMENTS
      STEPWEEK
      STEPMONTH
    ]
    @builder = GlobalCollect::Builders::InsertOrderWithPayment::Order.new(
      Hash[*fields.zip(fields)]
    )
    @builder.build(@node)
    xml = @node.target!
    
    xml.should have_xpath("/ORDER")
    fields.each do |field|
      xml.should match_xpath("/ORDER/#{field}", field)
    end
  end
end
