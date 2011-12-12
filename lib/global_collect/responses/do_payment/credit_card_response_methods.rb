# -*- encoding : utf-8 -*-
module GlobalCollect::Responses::DoPayment
  # WDL §5.13.2 specifies the possible return keys
  module CreditCardResponseMethods
    [
      "CURRENCY CODE"        ,
      "AMOUNT"               ,
      "PAYMENT REFERENCE"    ,
      "ADDITIONAL REFERENCE" ,
      "EXTERNAL REFERENCE"   ,
      "STATUS ID"            ,
      "STATUS DATE"          ,
      "AVS RESULT"           ,
      "CVV RESULT"           ,
      "FRAUD RESULT"         ,
      "FRAUD CODE"           ,
      "FRAUD NEURAL"         ,
      "FRAUD CRF"            ,
      "AUTHORISATION CODE"
    ].each do |meth|
      define_method meth.downcase.gsub(/\s+/, "_") do
        row[meth.gsub(/\s+/, "")]
      end
    end

    def payment_status
      GlobalCollect::Const::PaymentStatus.from_code(status_id)
    end
  end
end
