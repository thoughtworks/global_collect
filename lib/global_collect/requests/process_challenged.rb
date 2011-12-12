# -*- encoding : utf-8 -*-
module GlobalCollect::Requests
  class ProcessChallenged < GlobalCollect::Requests::Simple
    # WDL §5.30
    def initialize(order_id, effort_id=nil, attempt_id=nil)
      super("PROCESS_CHALLENGED", { 
        "ORDERID"   => order_id,
        "EFFORTID"  => effort_id,
        "ATTEMPTID" => attempt_id
      })
    end
    
    def wrapper; "PAYMENT"; end
    
    def fields
      {
        "ORDERID"   => ["N10", "R"],
        "EFFORTID"  => ["N5",  "O"],
        "ATTEMPTID" => ["N5",  "O"]
      }
    end
  end
end
