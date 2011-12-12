# -*- encoding : utf-8 -*-
module GlobalCollect::RequestModels::SetPayment
  class Payment < GlobalCollect::RequestModels::Base
    # WDL §5.33.1 specifies the full list of possible fields
    def fields
      super.merge({
        "ORDERID"          => ["N10", "R"],
        "EFFORTID"         => ["N5",  "O"],
        "PAYMENTPRODUCTID" => ["N5",  "R"],
        "AMOUNT"           => ["N12", "O"],
        "CURRENCYCODE"     => ["AN3", "O"],
        "DATECOLLECT"      => ["D8",  "O"]
      })
    end
  end
end


