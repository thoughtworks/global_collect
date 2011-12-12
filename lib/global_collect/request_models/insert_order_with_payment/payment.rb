# -*- encoding : utf-8 -*-
module GlobalCollect::RequestModels::InsertOrderWithPayment
  class Payment < GlobalCollect::RequestModels::Base
    # WDL §5.28.1 TABLE 105 specifies the full list of possible fields
    def fields
      super.merge({
        "PAYMENTPRODUCTID" => ["N5"   , "R"],
        "AMOUNT"           => ["N12"  , "R"],
        "AMOUNTSIGN"       => ["AN1"  , "O"],
        "CURRENCYCODE"     => ["AN3"  , "R"],
        "LANGUAGECODE"     => ["AN2"  , "R"],
        "COUNTRYCODE"      => ["AN2"  , "R"],
        "HOSTEDINDICATOR"  => ["N1"   , "O"],
        "RETURNURL"        => ["AN512", "O"]
      })
    end
  end
end
