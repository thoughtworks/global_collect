# -*- encoding : utf-8 -*-
module GlobalCollect::Builders::DoRefund
  class Payment < Struct.new(:payment)
    def build(node)
      node.tag!("PAYMENT") do |payment_node|
        payment_fields.each do |field|
          payment_node.tag!(field, payment[field]) if payment[field]
        end
      end
    end
    
    # WDL §5.28 Table 105 specifies general payment fields
    def payment_fields
      %w[
        ORDERID
        EFFORTID
        MERCHANTREFERENCE
        REFERENCEORIGPAYMENT 
        CURRENCYCODE
        AMOUNT
        COUNTRYCODE
        REFUNDDATE
        SURNAME
        FIRSTNAME
        PREFIXSURNAME
        TITLE
        COMPANYNAME
        COMPANYDATA
        STREET
        HOUSENUMBER
        ADDITIONALADDRESSINFO
        ZIP
        CITY
        STATE
        EMAILADDRESS
        EMAILTYPEINDICATOR
      ]
    end
  end
end
