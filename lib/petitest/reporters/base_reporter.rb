module Petitest
  module Reporters
    class BaseReporter
      # @param test_case [Petit::TestCase]
      def after_running_test_case(test_case)
        raise ::NotImplementedError.new("#{self.class}##{__method__} is not implemented yet")
      end

      # @param test_cases [Array<Petit::TestCase>]
      def after_running_test_cases(test_cases)
        raise ::NotImplementedError.new("#{self.class}##{__method__} is not implemented yet")
      end

      # @param test_case [Petit::TestCase]
      def before_running_test_case(test_case)
        raise ::NotImplementedError.new("#{self.class}##{__method__} is not implemented yet")
      end

      # @param test_cases [Array<Petit::TestCase>]
      def before_running_test_cases(test_cases)
        raise ::NotImplementedError.new("#{self.class}##{__method__} is not implemented yet")
      end
    end
  end
end
