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
  GlobalCollect::Requests::InsertOrderWithPayment.new(
    [
      GlobalCollect::RequestModels::InsertOrderWithPayment::Order.new(
        "ORDERID"           => "341",
        "AMOUNT"            => "100",
        "LANGUAGECODE"      => "en",
        "CURRENCYCODE"      => "USD",
        "COUNTRYCODE"       => "US",
        "MERCHANTREFERENCE" => "123114"
      ),
      GlobalCollect::Builders::InsertOrderWithPayment::Order
    ],
    [
      GlobalCollect::RequestModels::InsertOrderWithPayment::HostedCreditCardOnlinePayment.new(
        "PAYMENTPRODUCTID" => "3",
        "AMOUNT"           => "100",
        "CURRENCYCODE"     => "GBP",
        "LANGUAGECODE"     => "en",
        "COUNTRYCODE"      => "US"
      ),
      GlobalCollect::Builders::InsertOrderWithPayment::HostedCreditCardOnlinePayment
    ]
  )
)
p response.success?
