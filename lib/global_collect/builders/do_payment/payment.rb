# -*- encoding : utf-8 -*-
module GlobalCollect::Builders::DoPayment
  class Payment < Struct.new(:payment)
    def build(node)
      node.tag!("PAYMENT") do |payment_node|
        payment_fields.each do |field|
          payment_node.tag!(field, payment[field]) if payment[field]
        end
      end
    end

    # WDL §5.13.1 specifies general payment fields
    def payment_fields
      %w[
        MERCHANTREFERENCE
        ORDERID
        EFFORTID
        PAYMENTPRODUCTID
        AMOUNT
        AMOUNTSIGN
        CURRENCYCODE
        HOSTEDINDICATOR
        RETURNURL
      ]
    end
  end
end
