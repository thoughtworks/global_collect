# -*- encoding : utf-8 -*-
require 'rubygems'
require File.join(File.dirname(__FILE__), '..', "lib", "global_collect")


require 'global_collect/test_helper'
env = :test
auth = :ip_check
install_canned_response(:merchant_link, env, auth, :successful, :get_order_status, :v2)

GlobalCollect.merchant_id           = ""
GlobalCollect.authentication_scheme = auth
GlobalCollect.environment           = env
GlobalCollect.ip_address            = ""
#GlobalCollect.wire_log_file         = File.join(File.dirname(__FILE__), "gc.log")

client    = GlobalCollect.merchant_link_client

req = GlobalCollect::Requests::GetOrderStatus.new("53")
req.version = "1.0"
response  = client.make_request(req)
p response.request_id == "350556"
