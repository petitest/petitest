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
        check(
          message: message,
          template: "Given block returned falsy",
          &block
        )
      else
        actual = actual_or_message
        check(
          message: message,
          template: "%{actual} is not truthy",
          template_variables: {
            actual: actual,
          },
        ) do
          actual
        end
      end
    end

    private

    # @param message [String, nil]
    # @param template [String]
    # @param template_variables [Hash, nil]
    def check(
      message:,
      template:,
      template_variables: {}
    )
      unless yield
        raise ::Petitest::AssertionFailureError.new(
          additional_message: message,
          template: template,
          template_variables: template_variables,
        )
      end
    end
  end
end
