# -*- encoding : utf-8 -*-
require 'rubygems'
require File.join(File.dirname(__FILE__), '..', "lib", "global_collect")
require 'pp'

path = "something.mt1"
report = GlobalCollect::LogParsing::CollectionReport::ReportFile.new(path)
report.parse
pp report.data

path = "something.csv"
report = GlobalCollect::LogParsing::CollectionReport::AppendixReportFile.new(path)
report.parse
pp report.data
