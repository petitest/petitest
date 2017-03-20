module Petitest
  module Assertions
    # @param actual [Object]
    # @param user_specified_message [String, nil]
    def assert(actual, user_specified_message = nil)
      check(
        assertion_failure_message: ::Petitest::AssertionFailureMessage.new(
          template: "%{actual} is not truthy",
          template_variables: {
            actual: actual,
          },
          user_specified_message: user_specified_message,
        ),
        result: actual,
      )
    end

    # @param expected [Object]
    # @param actual [Object]
    # @param user_specified_message [String, nil]
    def assert_equal(expected, actual, user_specified_message = nil)
      result = expected == actual
      check(
        assertion_failure_message: ::Petitest::AssertionFailureMessage.new(
          template: "%{expected} expected but was %{actual}",
          template_variables: {
            actual: actual,
            expected: expected,
          },
          user_specified_message: user_specified_message,
        ),
        result: result,
      )
    end

    private

    # @param assertion_failure_message [Petitest::AssertionFailureMessage]
    # @param result [Boolean]
    def check(assertion_failure_message:, result:)
      unless result
        raise ::Petitest::AssertionFailureError.new(assertion_failure_message)
      end
    end
  end
end
