# -*- encoding : utf-8 -*-
module GlobalCollect::RequestModels::DoPayment
  class Payment < GlobalCollect::RequestModels::Base
    def suggested_response_mixins
      [
        GlobalCollect::Responses::SuccessRow,
        GlobalCollect::Responses::DoPayment::ResponseMethods
      ]
    end
    # WDL §5.13.1 specifies the full list of possible fields
    def fields
      super.merge({
        "MERCHANTREFERENCE" => ["AN30" , "R"],
        "ORDERID"           => ["N10"  , "R"],
        "EFFORTID"          => ["N5"   , "O"],
        "PAYMENTPRODUCTID"  => ["N5"   , "R"],
        "AMOUNT"            => ["N12"  , "O"],
        "AMOUNTSIGN"        => ["AN1"  , "O"],
        "CURRENCYCODE"      => ["AN3"  , "R"],
        "HOSTEDINDICATOR"   => ["N1"   , "O"],
        "RETURNURL"         => ["AN512", "O"]
      })
    end
  end
end


