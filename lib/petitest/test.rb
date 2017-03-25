module Petitest
  class Test
    TEST_METHOD_NAME_PREFIX = "test_"

    class << self
      attr_accessor :current_description

      attr_writer :description

      attr_writer :metadata

      # @return [Array<Class>]
      def children
        @children ||= []
      end

      # @return [String]
      def description
        @description ||= name
      end

      # @return [Hash{Symbol => String}]
      def description_by_method_name
        @description_by_method_name ||= {}
      end

      # @return [Petitest::TestGroup]
      def generate_test_group
        ::Petitest::TestGroup.new(test_class: self)
      end

      # @return [String, nil]
      def full_description
        test_ancestors.reverse.map(&:description).join(" ")
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

      # @note Override
      def method_added(method_name)
        super
        if current_description && check_if_test_method_name(method_name)
          description_by_method_name[method_name] = current_description
          clear_current_description
        end
      end

      # @return [Array<Class>]
      def test_ancestors
        @test_ancestors ||= ancestors.each_with_object([]) do |klass, classes|
          if klass == ::Petitest::Test
            break classes
          end
          if klass.is_a?(::Class)
            classes << klass
          end
        end
      end

      # @return [Array<Symbol>]
      def test_method_names
        public_instance_methods.select do |method_name|
          check_if_test_method_name(method_name)
        end
      end

      def undefine_test_methods
        test_method_names.each do |method_name|
          undef_method(method_name)
        end
      end

      private

      # @param method_name [Symbol]
      # @return [Boolean]
      def check_if_test_method_name(method_name)
        method_name.to_s.start_with?(TEST_METHOD_NAME_PREFIX)
      end

      def clear_current_description
        self.current_description = nil
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

    # @param message [String, nil]
    def skip(message = nil)
      raise ::Petitest::AssertionSkipError.new(message)
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
