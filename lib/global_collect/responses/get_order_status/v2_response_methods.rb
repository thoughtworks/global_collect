# -*- encoding : utf-8 -*-
module GlobalCollect::Responses::GetOrderStatus
  # WDL §5.23.3 specifies the possible return keys
  module V2ResponseMethods
    
    def statuses
      status_hashes.map{|status_hash| OrderStatus.new(status_hash) }
    end
    
    private
    
    def status_hashes
      response['STATUS'].is_a?(Array) ? response['STATUS'] : [response['STATUS']]
    end
    
    class OrderStatus < Struct.new(:status_hash)
      [
        "MERCHANT ID"           ,
        "ORDER ID"              ,
        "EFFORT ID"             ,
        "ATTEMPT ID"            ,
        "PAYMENT METHOD ID"     ,
        "PAYMENT PRODUCT ID"    ,
        "PAYMENT REFERENCE"     ,
        "MERCHANT REFERENCE"    ,
        "STATUS ID"             ,
        "STATUS DATE"           ,
        "CURRENCY CODE"         ,
        "AMOUNT"                ,
        "TOTAL AMOUNT PAID"     ,
        "TOTAL AMOUNT REFUNDED" ,
        "CREDIT CARD NUMBER"    ,
        "EXPIRY DATE"           ,
        "FRAUD RESULT"          ,
        "FRAUD CODE"            ,
        "FRAUD NEURAL"          ,
        "FRAUD RCF"             ,
        "AVS RESULT"            ,
        "CVV RESULT"            ,
        "AUTHORISATION CODE"    ,
        "ECI"                   ,
        "CAVV"                  ,
        "XID"
      ].each do |meth|
        define_method meth.downcase.gsub(/\s+/, "_") do
          status_hash[meth.gsub(/\s+/, "")]
        end
      end
      
      def payment_status
        GlobalCollect::Const::PaymentStatus.from_code(status_id)
      end
      
      def payment_product
        GlobalCollect::Const::PaymentProduct.from_code(payment_product_id)
      end
     
      # NOTE: these error fields correspond to the potential errors on the order
      # or payment, not on this response.
      # Those can be found in the #error object of the response.
      def errors
        return [] unless status_hash['ERRORS']
        errs = status_hash['ERRORS']['ERROR'].is_a?(Array) ? status_hash['ERRORS']['ERROR'] : [status_hash['ERRORS']['ERROR']]
        errs.map{|err| OrderStatusError.new(err['CODE'].to_i, err['MESSAGE']) }
      end
    end
    class OrderStatusError < Struct.new(:code, :message); end
  end
end

