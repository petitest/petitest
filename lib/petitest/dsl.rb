module Petitest
  module DSL
    # @param current_description [String]
    def desc(current_description)
      self.current_description = current_description
    end

    # @param description [String]
    # @param metadata [Hash{Symbol => Object}]
    def sub_test(description, metadata = {}, &block)
      child = ::Class.new(self)
      child.description = description
      child.metadata = self.metadata.merge(metadata)
      child.undefine_test_methods
      child.class_eval(&block)
      child
    end

    # @param description [String]
    # @param metadata [Hash{Symbol => Object}]
    def test(description, metadata = {}, &block)
      block ||= -> { skip }
      desc(description)
      define_method("test_#{description}", &block)
    end
  end
end
