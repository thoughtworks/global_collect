# -*- encoding : utf-8 -*-
require 'rubygems'
require File.join(File.dirname(__FILE__), '..', "lib", "global_collect")

GlobalCollect.merchant_id           = ""
GlobalCollect.authentication_scheme = :ip_check
GlobalCollect.environment           = :test
GlobalCollect.ip_address            = ""
#GlobalCollect.wire_log_file         = File.join(File.dirname(__FILE__), "gc.log")

client    = GlobalCollect.merchant_link_client

req = GlobalCollect::Requests::GetOrderStatus.new("53")
req.version = "2.0"
response  = client.make_request(req)
p response.success?
