# -*- encoding : utf-8 -*-
module GlobalCollect
  class ApiClient
    include HTTParty
    # WDL §4 specifies the body should be xml
    format :xml
    # WDL §3.1 specifies the content type
    headers "Content-Type" => "text/xml; charset=utf-8"
    # WDL §3.6 recommends this timeout
    DEFAULT_TIMEOUT = 70
    # Net::HTTP warns that debug_output should not be set in production
    # because it is a security problem.
    debug_output(nil)
    
    
    attr_reader :service, :environment, :authentication
    def initialize(service, environment, authentication)
      @serivce = service
      @environment = environment
      @authentication = authentication
      @service_url = ApiClient.service_url(service, environment, authentication)
    end

    def make_request(request, add_mixins=true)
      xml = request.to_xml
      GlobalCollect.wire_logger.info("POST [#{request.action} v#{request.version}] => [#{@service_url}] - body:\n#{xml}")
      
      response = nil
      request_time = Benchmark.realtime do
        response = self.class.post(@service_url,
          :body     => xml,
          :timeout  => DEFAULT_TIMEOUT
        )
      end

      unless response
        error_message = "Request [#{request.action} v#{request.version}] => [#{@service_url}] failed! No response!"
        GlobalCollect.wire_logger.error(error_message)
        raise error_message
      end
      GlobalCollect.wire_logger.info("RESP [#{request.action} v#{request.version}] => #{response.code} - #{request_time} s - body:\n#{response.body}")

      base = GlobalCollect::Responses::Base.new(response.parsed_response, response.body)
      raise "Malformed response to #{request.action} request! Body: '#{response.body}'" if base.malformed?
      request.suggested_response_mixins.each{|m| base.extend(m) } if add_mixins
      base
    end

    def self.service_url(service, environment, authentication)
      # WDL §§3.4-5 specify the allowed arguments
      raise ArgumentError.new("Only [Hosted] Merchant Link is currently supported!") unless [:merchant_link].include?(service)
      raise ArgumentError.new("Only :test and :production are valid environemnts!") unless [:test, :production].include?(environment)
      raise ArgumentError.new("Only :ip_check and :client_auth are valid authentication schemes!") unless [:ip_check, :client_auth].include?(authentication)
      {
        :merchant_link => {
          # WDL §3.4 specifies the test environment urls
          :test       => {
            :ip_check     => "https://ps.gcsip.nl/wdl/wdl",
            :client_auth  => "https://ca.gcsip.nl/wdl/wdl"
          },
          # WDL §3.5 specifies the prodution environment urls
          :production => {
            :ip_check     => "https://ps.gcsip.com/wdl/wdl",
            :client_auth  => "https://ca.gcsip.com/wdl/wdl"
          }
        }
      }[service][environment][authentication]
    end
  end
end
