module Petitest
  class TestGroup
    TEST_METHOD_NAME_PREFIX = "test_"

    class << self
      # @return [Array<Class>]
      def descendants
        @@descendants ||= []
      end

      # @note Override
      def inherited(sub_class)
        super
        descendants << sub_class
      end

      # @return [Array<Petit::TestCase]
      def test_cases
        descendants.flat_map do |test_group_class|
          test_group_class.test_methods.map do |test_method|
            ::Petitest::TestCase.new(
              test_group_class: test_group_class,
              test_method: test_method,
            )
          end
        end
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
    end

    # @param actual_or_message [Object]
    # @param message [String, nil]
    def assert(actual_or_message = nil, message = nil, &block)
      if block
        check(message || "Given block returned falsy", &block)
      else
        actual = actual_or_message
        check(message || "#{actual} is not truthy") do
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
