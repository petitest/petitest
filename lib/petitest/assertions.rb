module Petitest
  module Assertions
    # @param actual_or_message [Object]
    # @param message [String, nil]
    def assert(actual_or_message = nil, message = nil, &block)
      if block
        assert_block(actual_or_message, &block)
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

    # @param message [String, nil]
    def assert_block(message = nil, &block)
      check(
        message: message,
        template: "Given block returned falsy",
        &block
      )
    end

    # @param expected [Object]
    # @param actual [Object]
    # @param message [String, nil]
    def assert_equal(expected, actual, message = nil)
      check(
        message: message,
        template: "%{expected} expected but was %{actual}",
        template_variables: {
          actual: actual,
          expected: expected,
        },
      ) do
        expected == actual
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
