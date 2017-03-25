module Petitest
  module DSL
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
      self.description(description)
      define_method("test_#{description}", &block)
    end
  end
end
