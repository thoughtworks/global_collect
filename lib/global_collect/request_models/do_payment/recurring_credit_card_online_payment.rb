require File.join(File.dirname(__FILE__), 'recurring_payment')

module GlobalCollect::RequestModels::DoPayment
  class RecurringCreditCardOnlinePayment < RecurringPayment
    def initialize(attributes)
      super(attributes)
      @attributes["CVVINDICATOR"] = "8"
    end
    def suggested_response_mixins
      super + [GlobalCollect::Responses::DoPayment::CreditCardResponseMethods]
    end
    def fields
      #
      # Per # WDL §5.13 "Create Additional Payments" section, the CVVINDICATOR
      # must be 8 for recurring payments.
      #
      super.merge({
        "CVVINDICATOR" => ["N1", "R"]
      })
    end
  end
end


