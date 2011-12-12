# -*- encoding : utf-8 -*-
require File.join(File.dirname(__FILE__), 'payment')

module GlobalCollect::Builders::InsertOrderWithPayment
  class CreditCardOnlinePayment < Payment
    # WDL §5.28 Table 106 specifies credit card payment fields
    def payment_fields
      super + %w[
        EXPIRYDATE             
        CREDITCARDNUMBER       
        ISSUENUMBER            
        CVV                    
        CVVINDICATOR           
        AVSINDICATOR           
        AUTHENTICATIONINDICATOR
        STTINDICATOR           
        FIRSTNAME              
        PREFIXSURNAME          
        SURNAME                
        STREET                 
        HOUSENUMBER            
        CUSTOMERIPADDRESS      
        ADDITIONALADDRESSINFO  
        ZIP                    
        CITY                   
        STATE                  
        PHONENUMBER            
        EMAIL                  
        BIRTHDATE              
        DCCINDICATOR           
        ISSUERAMOUNT           
        ISSUERCURRENCYCODE     
        MARGINRATEPERCENTAGE   
        EXCHANGERATESOURCENAME 
        EXCHANGERATE           
        EXCHANGERATEVALIDTO    
        MAC                    
      ]
    end
  end
end
