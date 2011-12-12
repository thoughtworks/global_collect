# -*- encoding : utf-8 -*-
module GlobalCollect::RequestModels::DoRefund
  class PaypalPayment < GlobalCollect::RequestModels::DoRefund::Payment
    def initialize(attributes)
      super(attributes)
      @attributes["PAYMENTPRODUCTID"] = "1040"
    end

    # Merchant Guide for Paypal v6.1 states that we need to set PAYMENTPRODUCTID
    # to '1040' to refund a Paypal payment.
    def fields
      super.merge({
        "PAYMENTPRODUCTID" => ["N4",  "R"]
      })
    end
  end
end

