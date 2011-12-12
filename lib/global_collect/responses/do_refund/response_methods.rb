# -*- encoding : utf-8 -*-
module GlobalCollect::Responses::DoRefund
  # WDL §5.16.2 specifies the possible return keys
  module ResponseMethods
    [
      "MERCHANT ID"          ,
      "ORDER ID"             ,
      "EFFORT ID"            ,
      "ATTEMPT ID"           ,
      "STATUS ID"            ,
      "STATUS DATE"          ,
      "PAYMENT REFERENCE"    ,
      "ADDITIONAL REFERENCE" ,
      "EXTERNAL REFERENCE"
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
