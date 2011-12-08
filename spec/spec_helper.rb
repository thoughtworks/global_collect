require 'rubygems'

$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require 'global_collect'
# initialiaze the logger and silence it for the tests
GlobalCollect.wire_logger.level = 4

require 'global_collect/test_helper'

FakeWeb.allow_net_connect = false
def wire_up_response(success, action, version)
  install_canned_response(:merchant_link, :test, :ip_check, success, action, version)
end

require 'crack'

require 'rexml/document'
require 'rexml/element'

RSpec::Matchers.define :have_xpath do |xpath|

  match do |response|
    doc = response.is_a?(REXML::Document) ? response : REXML::Document.new(response)
    match = REXML::XPath.match(doc, xpath)
    match.any?
  end

end

RSpec::Matchers.define :match_xpath do |xpath|

  match do |response, val|
    doc = response.is_a?(REXML::Document) ? response : REXML::Document.new(response)
    ok = true
    REXML::XPath.each(doc, xpath) do |e|
      actual_val = case e
                   when REXML::Attribute
                     e.to_s
                   when REXML::Element
                     e.text
                   else
                     e.to_s
                   end
      next false unless val == actual_val
    end
    ok
  end
end
