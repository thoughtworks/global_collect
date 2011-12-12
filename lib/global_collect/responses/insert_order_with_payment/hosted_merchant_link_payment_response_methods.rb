# -*- encoding : utf-8 -*-
module GlobalCollect::Responses::InsertOrderWithPayment
  # WDL §5.28.2 TABLE 125 specifies the possible return keys
  module HostedMerchantLinkPaymentResponseMethods
    [
      "FORM METHOD"  ,
      "FORM ACTION"  ,
      "REF"          ,
      "MAC"          ,
      "RETURN MAC"
    ].each do |meth|
      define_method meth.downcase.gsub(/\s+/, "_") do
        row[meth.gsub(/\s+/, "")]
      end
    end
  end
end
