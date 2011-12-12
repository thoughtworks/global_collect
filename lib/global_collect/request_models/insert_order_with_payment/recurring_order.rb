# -*- encoding : utf-8 -*-
module GlobalCollect::RequestModels::InsertOrderWithPayment
  class RecurringOrder < Order
    def initialize(attributes)
      super(attributes)
      # WDL Appendix F specifies the recurring order type as '4'
      @attributes["ORDERTYPE"] = "4"
      # WDL Appendix F specifies the recurring order should have STEPMONTH
      # set to a filler value. They say a default of "120" is fine.
      @attributes["STEPMONTH"] ||= "120"
    end
    def fields
      super.merge({
        "STEPMONTH" => ["N5", "R"]
      })
    end
  end
end
