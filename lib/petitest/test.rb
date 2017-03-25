module Petitest
  class Test
    TEST_METHOD_NAME_PREFIX = "test_"

    class << self
      attr_writer :description

      attr_writer :metadata

      attr_writer :nest_level

      # @return [Array<Class>]
      def children
        @children ||= []
      end

      # @return [String]
      def description
        @description ||= name
      end

      # @return [Petitest::TestGroup]
      def generate_test_group
        ::Petitest::TestGroup.new(test_class: self)
      end

      # @return [String, nil]
      def full_description
        descriptions = concrete_test_ancestors.reverse.map(&:description)
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
      def sub_test(description, metadata = {}, &block)
        child = ::Class.new(self)
        child.nest_level = nest_level + 1
        child.description = description
        child.metadata = self.metadata.merge(metadata)
        child.undefine_test_methods
        child.class_eval(&block)
        child
      end

      # @return [Array<String>]
      def test_method_names
        public_instance_methods.map(&:to_s).select do |method_name|
          method_name.start_with?(TEST_METHOD_NAME_PREFIX)
        end
      end

      def undefine_test_methods
        test_method_names.each do |method_name|
          undef_method(method_name)
        end
      end

      private

      # @return [Array<Class>]
      def concrete_test_ancestors
        ancestors.each_with_object([]) do |klass, classes|
          if klass == ::Petitest::Test
            break classes
          end
          if klass.is_a?(::Class)
            classes << klass
          end
        end
      end
    end

    # @param test_group [Petitest::TestGroup]
    # @param test_method_name [Symbol]
    def initialize(
      test_group:,
      test_method_name:
    )
      @test_group = test_group
      @test_method_name = test_method_name
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

    # @return [Petitest::TestRunner]
    def runner
      @runner ||= Petitest::TestRunner.new(
        test: self,
        test_group: @test_group,
        test_method_name: @test_method_name,
      )
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
