# -*- encoding : utf-8 -*-
require 'rubygems'
require File.join(File.dirname(__FILE__), '..', "lib", "global_collect")
require 'pp'

path = "something.asc"
report = GlobalCollect::LogParsing::FinancialStatement::ReportFile.new(path)
report.parse
pp report.data
