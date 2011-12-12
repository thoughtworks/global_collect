# -*- encoding : utf-8 -*-
module GlobalCollect::Requests
  class GetOrderStatus < GlobalCollect::Requests::Simple
    # WDL §5.23
    def initialize(order_id)
      super("GET_ORDERSTATUS", { "ORDERID" => order_id })
    end
    
    def suggested_response_mixins
      case self.version
      when "1.0" then [GlobalCollect::Responses::GetOrderStatus::V1ResponseMethods]
      when "2.0" then [GlobalCollect::Responses::GetOrderStatus::V2ResponseMethods]
      else []
      end
    end
    
    def wrapper; "ORDER"; end
    
    def fields
      {
        "ORDERID" => ["N10", "R"]
      }
    end
  end
end
