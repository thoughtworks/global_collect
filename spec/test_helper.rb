# -*- encoding : utf-8 -*-
require 'fakeweb'

def support_path(filename)
  File.expand_path File.join(File.dirname(__FILE__), 'support', filename)
end

def read_support_file(filename)
  File.read support_path(filename)
end

def filename_for(success, action, version)
  filename = [
    success,
    action,
    version,
    "response"
  ].map(&:to_s).join("_") + ".xml"
end

def install_canned_response(service, env, auth_scheme, success, action, version)
  response_body = read_support_file filename_for(success, action, version)
  service_url = GlobalCollect::ApiClient.service_url(service, env, auth_scheme)
  FakeWeb.register_uri(:post, service_url, :body => response_body)
end

def parse_canned_response(success, action, version)
  response_body = read_support_file filename_for(success, action, version)
  GlobalCollect::Responses::Base.new Crack::XML.parse(response_body), response_body
end
