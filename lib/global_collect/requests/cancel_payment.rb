require File.join(File.dirname(__FILE__), 'simple')

module GlobalCollect::Requests
  class CancelPayment < GlobalCollect::Requests::Simple
    # WDL §5.2
    def initialize(order_id, effort_id, attempt_id)
      super("CANCEL_PAYMENT", {
        "ORDERID"   => order_id,
        "EFFORTID"  => effort_id,
        "ATTEMPTID" => attempt_id
      })
    end

    def wrapper; "PAYMENT"; end

    def fields
      {
        "ORDERID"   => ["N10", "R"],
        "EFFORTID"  => ["N5",  "R"],
        "ATTEMPTID" => ["N5",  "R"]
      }
    end
  end
end
