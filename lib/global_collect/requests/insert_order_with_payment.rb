# -*- encoding : utf-8 -*-
module GlobalCollect::Requests
  class InsertOrderWithPayment < GlobalCollect::Requests::Composite
    # WDL §5.28 requires ORDER and PAYMENT nodes in PARAMS, but may optionally
    # include AIRLINEDATA and ORDERLINES, as well.
    def initialize(order_and_builder, payment_and_builder, *extra_pairs)
      all_pairs = [order_and_builder, payment_and_builder] + extra_pairs
      super("INSERT_ORDERWITHPAYMENT", all_pairs)
    end
  end
end
