# -*- encoding : utf-8 -*-
module GlobalCollect::Requests
  class DoPayment < GlobalCollect::Requests::Composite
    # WDL §5.13 requires at least a PAYMENT node in PARAMS, but may optionally
    # include AIRLINEDATA, as well.
    def initialize(payment_and_builder, *extra_pairs)
      all_pairs = [payment_and_builder] + extra_pairs
      super("DO_PAYMENT", all_pairs)
    end
  end
end
