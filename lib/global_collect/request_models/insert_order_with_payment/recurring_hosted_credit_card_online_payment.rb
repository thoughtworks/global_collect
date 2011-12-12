# -*- encoding : utf-8 -*-
require File.join File.dirname(__FILE__), 'hosted_credit_card_online_payment'

module GlobalCollect::RequestModels::InsertOrderWithPayment
  class RecurringHostedCreditCardOnlinePayment < HostedCreditCardOnlinePayment
    def initialize(attributes)
      super(attributes)
      # WDL Appendix F specifies the recurring payment CVVINDICATOR is '8'
      @attributes["CVVINDICATOR"] = "8"
    end
  end
end
