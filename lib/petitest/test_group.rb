module Petitest
  class TestGroup
    TEST_METHOD_NAME_PREFIX = "test_"

    class << self
      # @return [String, nil]
      attr_accessor :description

      attr_writer :metadata

      attr_writer :nest_level

      # @return [Array<Class>]
      def children
        @children ||= []
      end

      # @return [Array<Class>]
      def descendants
        children.flat_map(&:children)
      end

      # @return [String, nil]
      def full_description
        descriptions = test_group_ancestors.reverse.map(&:description).compact
        unless descriptions.empty?
          descriptions.join(" ")
        end
      end

      # @note Override
      def inherited(child)
        super
        children << child
      end

      # @return [Hash{Symbol => Object}]
      def metadata
        @metadata ||= {}
      end

      # @return [Integer]
      def nest_level
        @nest_level ||= 0
      end

      # @param description [String]
      # @param metadata [Hash{Symbol => Object}]
      def sub_test_group(description, metadata = {}, &block)
        child = ::Class.new(self)
        child.nest_level = nest_level + 1
        child.description = description
        child.metadata = self.metadata.merge(metadata)
        child.undefine_test_methods
        child.class_eval(&block)
        child
      end

      # @return [Array<Petit::TestCase>]
      def test_cases
        @test_cases ||= test_methods.map do |test_method|
          ::Petitest::TestCase.new(
            test_group_class: self,
            test_method: test_method,
          )
        end
      end

      # @return [Array<Petit::TestCase>]
      def test_cases_and_children_test_cases
        test_cases + children.flat_map(&:test_cases_and_children_test_cases)
      end

      # @return [Array<String>]
      def test_method_names
        public_instance_methods.map(&:to_s).select do |method_name|
          method_name.start_with?(TEST_METHOD_NAME_PREFIX)
        end
      end

      # @return [Array<Petitest::TestMethod>]
      def test_methods
        test_method_names.map do |method_name|
          unbound_method = public_instance_method(method_name)
          ::Petitest::TestMethod.new(
            line_number: unbound_method.source_location[1],
            method_name: method_name.to_s,
            path: unbound_method.source_location[0],
          )
        end
      end

      def undefine_test_methods
        test_method_names.each do |method_name|
          undef_method(method_name)
        end
      end

      private

      # @return [Array<Class>]
      def test_group_ancestors
        ancestors.each_with_object([]) do |klass, classes|
          if klass == ::Petitest::TestGroup
            break classes
          end
          if klass.is_a?(::Class)
            classes << klass
          end
        end
      end
    end

    # @param actual_or_message [Object]
    # @param message [String, nil]
    def assert(actual_or_message = nil, message = nil, &block)
      if block
        message = actual_or_message
        check(message || "Expected given block to return truthy", &block)
      else
        actual = actual_or_message
        check(message || "Expected #{actual.inspect} to be truthy") do
          actual
        end
      end
    end

    private

    # @param message [String, nil]
    def check(message, &block)
      unless block.call
        raise ::Petitest::AssertionFailureError.new(message)
      end
    end
  end
end
