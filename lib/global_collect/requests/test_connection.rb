# -*- encoding : utf-8 -*-
module GlobalCollect::Requests
  class TestConnection < GlobalCollect::Requests::Simple
    # WDL §5.36
    def initialize
      super("TEST_CONNECTION", {})
    end
  end
end
