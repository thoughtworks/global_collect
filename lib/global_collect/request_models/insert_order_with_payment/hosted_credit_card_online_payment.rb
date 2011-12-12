# -*- encoding : utf-8 -*-
require File.join File.dirname(__FILE__), 'credit_card_online_payment'

module GlobalCollect::RequestModels::InsertOrderWithPayment
  class HostedCreditCardOnlinePayment < CreditCardOnlinePayment
    def initialize(attributes)
      super(attributes)
      @attributes["HOSTEDINDICATOR"] = "1"
    end
    
    def suggested_response_mixins
      super + [GlobalCollect::Responses::InsertOrderWithPayment::HostedMerchantLinkPaymentResponseMethods]
    end
    
    def fields
      super.merge({
        "EXPIRYDATE"              => ['N4',   'O'],
        "CREDITCARDNUMBER"        => ['N19',  'O']
      })
    end
  end
end
