# -*- encoding : utf-8 -*-
module GlobalCollect::Responses::DoPayment
  # WDL §5.13.2 specifies the possible return keys
  module ResponseMethods
    [
      "ORDERID"   ,
      "ATTEMPTID" ,
      "EFFORTID"
    ].each do |meth|
      define_method meth.downcase.gsub(/\s+/, "_") do
        row[meth.gsub(/\s+/, "")]
      end
    end
  end
end
