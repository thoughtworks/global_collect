# -*- encoding : utf-8 -*-
module GlobalCollect::Builders::SetPayment
  class Payment < Struct.new(:payment)
    def build(node)
      node.tag!("PAYMENT") do |payment_node|
        payment_fields.each do |field|
          payment_node.tag!(field, payment[field]) if payment[field]
        end
      end
    end
    
    # WDL §5.33.1 specifies general payment fields
    def payment_fields
      %w[
        ORDERID
        EFFORTID
        PAYMENTPRODUCTID
        AMOUNT
        CURRENCYCODE
        DATECOLLECT
      ]
    end
  end
end
