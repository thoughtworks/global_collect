# -*- encoding : utf-8 -*-
require 'rubygems'
require File.join(File.dirname(__FILE__), '..', "lib", "global_collect")

GlobalCollect.merchant_id           = ""
GlobalCollect.authentication_scheme = :ip_check
GlobalCollect.environment           = :test
GlobalCollect.ip_address            = ""
#GlobalCollect.wire_log_file         = File.join(File.dirname(__FILE__), "gc.log")

client    = GlobalCollect.merchant_link_client

puts "This is a multi-stage example. Please read the source for instructions."

# ===============================================================================
# To get this example to work, you need to insert a recurring order, as commented
# out below...
# ===============================================================================

# response  = client.make_request(
#   GlobalCollect::Requests::InsertOrderWithPayment.new(
#     [
#       GlobalCollect::RequestModels::InsertOrderWithPayment::RecurringOrder.new(
#         "ORDERID"           => "7777",
#         "AMOUNT"            => "100",
#         "LANGUAGECODE"      => "en",
#         "CURRENCYCODE"      => "USD",
#         "COUNTRYCODE"       => "US",
#         "MERCHANTREFERENCE" => "1231147777"
#       ),
#       GlobalCollect::Builders::InsertOrderWithPayment::RecurringOrder
#     ],
#     [
#       GlobalCollect::RequestModels::InsertOrderWithPayment::RecurringHostedCreditCardOnlinePayment.new(
#         "PAYMENTPRODUCTID" => "3",
#         "AMOUNT"           => "100",
#         "CURRENCYCODE"     => "GBP",
#         "LANGUAGECODE"     => "en",
#         "COUNTRYCODE"      => "US"
#       ),
#       GlobalCollect::Builders::InsertOrderWithPayment::RecurringHostedCreditCardOnlinePayment
#     ]
#   )
# )
# p response.success?

# ===============================================================================
# Then you need to visit the FORMACTION URL in a browser, and fill in some
# example credit card data.
# Then you need to wait overnight for it to become settle-able and settle it, as
# commented out below...
# ===============================================================================

# response  = client.make_request(
#   GlobalCollect::Requests::SetPayment.new(
#     [
#       GlobalCollect::RequestModels::SetPayment::Payment.new(
#         "ORDERID"           => "7777",
#         "PAYMENTPRODUCTID"  => "3"
#       ),
#       GlobalCollect::Builders::SetPayment::Payment
#     ]
#   )
# )
# p response.success?

# ===============================================================================
# Then finally, you can call DO_PAYMENT as below:
# ===============================================================================

# response  = client.make_request(
#   GlobalCollect::Requests::DoPayment.new(
#     [
#       GlobalCollect::RequestModels::DoPayment::RecurringCreditCardOnlinePayment.new(
#         "MERCHANTREFERENCE" => "1231147777",
#         "ORDERID"           => "7777",
#         "EFFORTID"          => "2", # increment implied EFFORTID of 1 from IOWP
#         "AMOUNT"            => "1400",
#         "CURRENCYCODE"      => "USD"
#       ),
#       GlobalCollect::Builders::DoPayment::RecurringCreditCardOnlinePayment
#     ]
#   )
# )
# p response.success?
