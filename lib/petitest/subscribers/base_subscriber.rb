module Petitest
  module Subscribers
    class BaseSubscriber
      # @param test_case [Petit::TestCase]
      def after_running_test_case(test_case)
      end

      # @param test_cases [Array<Petit::TestCase>]
      def after_running_test_cases(test_cases)
      end

      # @param test_group [Class]
      def after_running_test_group(test_group)
      end

      # @param test_case [Petit::TestCase]
      def before_running_test_case(test_case)
      end

      # @param test_cases [Array<Petit::TestCase>]
      def before_running_test_cases(test_cases)
      end

      # @param test_group [Class]
      def before_running_test_group(test_group)
      end
    end
  end
end
