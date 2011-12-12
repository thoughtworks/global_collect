require 'time'
require 'builder'
require 'httparty'
require 'find'
require 'logger'
require 'benchmark'
require 'fixed_width'

module GlobalCollect; end
module GlobalCollect::Builders; end
module GlobalCollect::LogParsing; end
module GlobalCollect::RequestModels; end
module GlobalCollect::Responses; end

lib_dir = File.dirname(__FILE__)
Dir[File.join(lib_dir, '**/*.rb')].sort.each do |f|
  require f
end

module GlobalCollect
  extend self

  attr_accessor :merchant_id
  attr_accessor :authentication_scheme
  attr_accessor :ip_address # only used if authentication_scheme is :ip_check
  attr_accessor :environment
  attr_accessor :default_api_version
  attr_accessor :wire_log_file
  attr_accessor :wire_logger

  def merchant_link_client
    GlobalCollect::ApiClient.new(:merchant_link, environment, authentication_scheme)
  end

  def wire_logger
    @wire_logger ||= if self.wire_log_file
      Logger.new(self.wire_log_file)
    else
      Logger.new(STDOUT)
    end
  end
end

GlobalCollect.default_api_version ||= "1.0"
