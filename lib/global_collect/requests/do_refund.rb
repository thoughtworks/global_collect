# -*- encoding : utf-8 -*-
module GlobalCollect::Requests
  class DoRefund < GlobalCollect::Requests::Composite
    # WDL §5.16 requires a PAYMENT node
    def initialize(payment_and_builder)
      super("DO_REFUND", [payment_and_builder])
    end
  end
end
