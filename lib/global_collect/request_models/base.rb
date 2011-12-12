# -*- encoding : utf-8 -*-
module GlobalCollect::RequestModels
  class Base
    attr_accessor :errors
    def suggested_response_mixins
      []
    end
    
    def fields
      {}
    end
    
    def initialize(attributes)
      @attributes = {}
      attributes.each {|k,v| self[k] = v }
    end
    
    def validate
      fields.each do |field, validations|
        validator = GlobalCollect::FieldValidator.new(*validations)
        unless validator.validate(@attributes[field])
          @errors = { field => "is invalid. Should conform to #{validations.inspect}" }
        end
      end
      return @errors.blank?
    end
    
    def [](key)
      raise ArgumentError.new("Invalid attribute name '#{key}'!") unless fields.key?(key)
      @attributes[key]
    end
    
    def []=(key, value)
      raise ArgumentError.new("Invalid attribute name '#{key}'!") unless fields.key?(key)
      @attributes[key] = value
    end
  end
end
