require File.join(File.dirname(__FILE__), 'payment')

module GlobalCollect::RequestModels::DoRefund
  class CreditCardPayment < Payment
    # WDL §5.16.1 specifies the full list of possible fields
    def fields
      super.merge({
        "PAYMENTPRODUCTID" => ["N5",  "O"],
        "CREDITCARDNUMBER" => ["N19", "O"],
        "EXPIRYDATE"       => ["N4",  "O"]
      })
    end
  end
end
