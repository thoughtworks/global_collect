# -*- encoding : utf-8 -*-
module GlobalCollect::Requests
  class SetPayment < GlobalCollect::Requests::Composite
    # WDL §5.33 requires a PAYMENT node and allows more optional nodes
    def initialize(payment_and_builder, *extra_pairs)
      all_pairs = [payment_and_builder] + extra_pairs
      super("SET_PAYMENT", all_pairs)
    end
  end
end
