require "petitest/reporters/base_reporter"

module Petitest
  module Reporters
    class NullReporter < ::Petitest::Reporters::BaseReporter
      # @note Override
      def after_running_test_case(test_case)
      end

      # @note Override
      def after_running_test_cases(test_cases)
      end

      # @note Override
      def before_running_test_case(test_case)
      end

      # @note Override
      def before_running_test_cases(test_cases)
      end
    end
  end
end
