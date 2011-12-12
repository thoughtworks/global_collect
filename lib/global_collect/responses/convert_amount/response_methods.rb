# -*- encoding : utf-8 -*-
module GlobalCollect::Responses::ConvertAmount
  # WDL §5.7.2 specifies the possible return keys
  module ResponseMethods
    def converted_amount
      row["CONVERTEDAMOUNT"]
    end
  end
end
