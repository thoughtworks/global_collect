# -*- encoding : utf-8 -*-
require 'rubygems'
require File.join(File.dirname(__FILE__), '..', "lib", "global_collect")

GlobalCollect.merchant_id           = ""
GlobalCollect.authentication_scheme = :ip_check
GlobalCollect.environment           = :test
GlobalCollect.ip_address            = ""
#GlobalCollect.wire_log_file         = File.join(File.dirname(__FILE__), "gc.log")

client    = GlobalCollect.merchant_link_client

response  = client.make_request(
  GlobalCollect::Requests::SetPayment.new(
    [
      GlobalCollect::RequestModels::SetPayment::Payment.new(
        "ORDERID"           => "33",
        "PAYMENTPRODUCTID"  => "3"
      ),
      GlobalCollect::Builders::SetPayment::Payment
    ]
  )
)
p response.success?
