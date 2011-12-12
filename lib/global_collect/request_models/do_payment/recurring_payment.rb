require File.join File.dirname(__FILE__), 'payment'

module GlobalCollect::RequestModels::DoPayment
  class RecurringPayment < Payment
    def fields
      # A recurring payment will never have the default EFFORTID of '1', hence
      # it is a required field.
      #
      # Also, a recurring payment recalls the existing payment information on
      # the order, thus does not require a PAYMENTPRODUCTID, per # WDL §5.13
      # "Variable amount recurring order payments" section.
      super.merge({
        "EFFORTID"         => ["N5", "R"],
        "PAYMENTPRODUCTID" => ["N5", "O"]
      })
    end
  end
end


