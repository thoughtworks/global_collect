# -*- encoding : utf-8 -*-
require 'rubygems'
require File.join(File.dirname(__FILE__), '..', "lib", "global_collect")
require 'pp'

path = "something.wr1"
report = GlobalCollect::LogParsing::PaymentReport::ReportFile.new(path)
report.parse
pp report.data
