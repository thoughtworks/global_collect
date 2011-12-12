# -*- encoding : utf-8 -*-
module GlobalCollect::Requests
  class Composite < GlobalCollect::Requests::Base
    
    def initialize(action, model_builder_pairs)
      unless model_builder_pairs.map(&:size).uniq == [2]
        raise ArgumentError.new("Models and builders must be in array pairs like [[model,builder_class],...]!")
      end
      @contents = model_builder_pairs
      super(action)
      @suggested_response_mixins = model_builder_pairs.map(&:first).map(&:suggested_response_mixins).flatten.uniq
    end
    
    def to_xml
      super do |params_node|
        @contents.each do |model,builder_class|
          raise "Invalid model #{model.inspect}. Errors: #{model.errors.inspect}!" unless model.validate
          builder = builder_class.new(model)
          builder.build(params_node) 
        end
      end
    end
  end
end
