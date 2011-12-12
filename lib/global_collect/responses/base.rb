# -*- encoding : utf-8 -*-
module GlobalCollect::Responses
  # WDL §4 specifies the generalized response
  # This base class is sufficient for many responses that don't include anything
  # more than the basic META, RESULT and/or ERROR nodes.
  # It is also a useful fallback if you want basic hash access to the actual
  # content of the response with just a few helper methods for traversal.
  class Base
    attr_reader :response_hash, :raw_response
    def initialize(response_hash, raw_response)
      @response_hash = response_hash
      @raw_response  = raw_response
    end

    def success?
      RESPONSE_STATUS_SUCCESS[result]
    end

    def action
      request['ACTION']
    end

    def response_datetime
      Time.parse(meta['RESPONSEDATETIME']) if meta['RESPONSEDATETIME']
    end

    def request_id
      meta['REQUESTID']
    end

    def version
      meta['VERSION']
    end

    def errors
      return [] if success?
      errs = response['ERROR'].is_a?(Array) ? response['ERROR'] : [response['ERROR']]
      return errs.map{|err| RequestError.new(err['CODE'].to_i, err['MESSAGE']) }
    end

    def malformed?
      !response_hash['XML']
    end

    protected

    def result
      response['RESULT']
    end

    def meta
      response['META']
    end

    # this structure is general to successful and unsuccessful response
    def response
      request['RESPONSE']
    end

    def request
      response_hash['XML']['REQUEST']
    end

    private

    RESPONSE_STATUS_SUCCESS = {
      'OK'  => true,
      'NOK' => false
    }
    class RequestError < Struct.new(:code, :message); end
  end
end
