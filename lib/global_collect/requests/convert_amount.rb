# -*- encoding : utf-8 -*-
module GlobalCollect::Requests
  class ConvertAmount < GlobalCollect::Requests::Simple
    # WDL §5.7
    def initialize(amount, source_currency, target_currency)
      super("CONVERT_AMOUNT", {
        "AMOUNT"             => amount,
        "SOURCECURRENCYCODE" => source_currency,
        "TARGETCURRENCYCODE" => target_currency
      })
    end
    
    def suggested_response_mixins
      [
        GlobalCollect::Responses::SuccessRow,
        GlobalCollect::Responses::ConvertAmount::ResponseMethods
      ]
    end
    
    def wrapper; "GENERAL"; end
    
    def fields
      {
        "AMOUNT"             => ["N12", "R"],
        "SOURCECURRENCYCODE" => ["AN3", "R"],
        "TARGETCURRENCYCODE" => ["AN3", "R"]
      }
    end
  end
end
