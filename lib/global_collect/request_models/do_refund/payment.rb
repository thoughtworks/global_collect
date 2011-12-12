# -*- encoding : utf-8 -*-
module GlobalCollect::RequestModels::DoRefund
  class Payment < GlobalCollect::RequestModels::Base
    def suggested_response_mixins
      [
        GlobalCollect::Responses::SuccessRow,
        GlobalCollect::Responses::DoRefund::ResponseMethods
      ]
    end
    
    # WDL §5.16.1 specifies the full list of possible fields
    def fields
      super.merge({
        "ORDERID"               => ["N10",  "R"],
        "EFFORTID"              => ["N5",   "O"],
        "MERCHANTREFERENCE"     => ["AN30", "R"],
        "REFERENCEORIGPAYMENT"  => ["AN30", "O"],
        "CURRENCYCODE"          => ["AN3",  "O"],
        "AMOUNT"                => ["N12",  "O"],
        "COUNTRYCODE"           => ["AN2",  "O"],
        "REFUNDDATE"            => ["D",    "O"],
        "SURNAME"               => ["AN35", "O"],
        "FIRSTNAME"             => ["AN15", "O"],
        "PREFIXSURNAME"         => ["AN15", "O"],
        "TITLE"                 => ["AN35", "O"],
        "COMPANYNAME"           => ["AN40", "O"],
        "COMPANYDATA"           => ["AN50", "O"],
        "STREET"                => ["AN50", "O"],
        "HOUSENUMBER"           => ["AN15", "O"],
        "ADDITIONALADDRESSINFO" => ["AN50", "O"],
        "ZIP"                   => ["AN10", "O"],
        "CITY"                  => ["AN40", "O"],
        "STATE"                 => ["AN35", "O"],
        "EMAILADDRESS"          => ["AN70", "O"],
        "EMAILTYPEINDICATOR"    => ["N1",   "O"]
      })
    end
  end
end

