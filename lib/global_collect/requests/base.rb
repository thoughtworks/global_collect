# -*- encoding : utf-8 -*-
module GlobalCollect::Requests
  class Base
    attr_accessor :action
    attr_reader :version
    attr_reader :suggested_response_mixins
    
    def initialize(action)
      @action = action
      @suggested_response_mixins ||= []
      @version = GlobalCollect::default_api_version
    end
    
    def version=(v)
      raise ArgumentError.new("Invalid version identifier!") unless %w[1.0 2.0].include?(v)
      @version = v
    end
    
    # WDL §3.1
    def default_xml_encoding_options
      { :encoding => "UTF-8" }
    end

    # WDL §4
    def to_xml
      xml = Builder::XmlMarkup.new
      xml.instruct!(:xml, default_xml_encoding_options)
      xml.tag!("XML") do |xml_node|
        xml_node.tag!("REQUEST") do |req_node|
          req_node.tag!("ACTION", @action)
          req_node.tag!("META") do |meta_node|
            meta_node.tag!("IPADDRESS" , GlobalCollect::ip_address ) if GlobalCollect::authentication_scheme == :ip_check
            meta_node.tag!("MERCHANTID", GlobalCollect::merchant_id)
            meta_node.tag!("VERSION"   , version)
          end
          req_node.tag!("PARAMS") do |params_node|
            yield(params_node)
          end
        end
      end
      xml.target!
    end
  end
end
