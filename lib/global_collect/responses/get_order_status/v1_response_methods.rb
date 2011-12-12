# -*- encoding : utf-8 -*-
module GlobalCollect::Responses::GetOrderStatus
  # WDL §5.23.2 specifies the possible return keys
  module V1ResponseMethods
    
    def statuses
      row_hashes.map{|row_hash| OrderStatus.new(row_hash) }
    end
    
    private
    
    def row_hashes
      response['ROW'].is_a?(Array) ? response['ROW'] : [response['ROW']]
    end
    
    class OrderStatus < Struct.new(:row_hash)
      [
        "MERCHANT ID"           ,
        "ORDER ID"              ,
        "EFFORT ID"             ,
        "ATTEMPT ID"            ,
        "PAYMENT REFERENCE"     ,
        "MERCHANT REFERENCE"    ,
        "STATUS ID"             ,
        "STATUS DATE"           ,
        "AMOUNT"                ,
        "CURRENCY CODE"         ,
        "PAYMENT METHOD ID"     ,
        "PAYMENT PRODUCT ID"    
      ].each do |meth|
        define_method meth.downcase.gsub(/\s+/, "_") do
          row_hash[meth.gsub(/\s+/, "")]
        end
      end
      
      def payment_status
        GlobalCollect::Const::PaymentStatus.from_code(status_id)
      end
     
      # NOTE: these error fields correspond to the potential errors on the order
      # or payment, not on this response.
      # Those can be found in the #error object of the response.
      def errors
        return [] unless row_hash['ERRORNUMBER'] || row_hash['ERRORMESSAGE']
        [OrderStatusError.new(row_hash['ERRORNUMBER'].to_i, row_hash['ERRORMESSAGE'])]
      end
    end
    class OrderStatusError < Struct.new(:code, :message); end
  end
end
