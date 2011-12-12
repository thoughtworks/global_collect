# -*- encoding : utf-8 -*-
module GlobalCollect::Requests
  class Simple < GlobalCollect::Requests::Base
    
    def initialize(action, fields_hash)
      super(action)
      @contents = fields_hash
    end
    
    def to_xml
      validate!
      super do |params_node|
        if wrapper
          params_node.tag!(wrapper) {|wrapper_node| build_keys(wrapper_node) }
        else
          build_keys(params_node)
        end
      end
    end
    
    protected
    def fields; {}; end
    
    def wrapper; nil; end
    
    def validate!
      fields.each do |key, validations|
        validator = GlobalCollect::FieldValidator.new(*validations)
        raise "Invalid field '#{key}'!" unless validator.validate(@contents[key])
      end
    end
    
    private
    
    def build_keys(node)
      fields.keys.each {|key| node.tag!(key, @contents[key]) }
    end
    
  end
end
