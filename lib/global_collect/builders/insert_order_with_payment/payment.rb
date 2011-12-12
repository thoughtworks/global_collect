# -*- encoding : utf-8 -*-
module GlobalCollect::Builders::InsertOrderWithPayment
  class Payment < Struct.new(:payment)
    def build(node)
      node.tag!("PAYMENT") do |payment_node|
        payment_fields.each do |field|
          payment_node.tag!(field, payment[field]) if payment[field]
        end
      end
    end
    
    # WDL §5.28 Table 105 specifies general payment fields
    def payment_fields
      %w[
        PAYMENTPRODUCTID
        AMOUNT
        AMOUNTSIGN
        CURRENCYCODE
        LANGUAGECODE
        COUNTRYCODE
        HOSTEDINDICATOR
        RETURNURL
      ]
    end
  end
end
