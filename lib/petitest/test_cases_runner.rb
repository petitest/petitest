module Petitest
  class TestCasesRunner
    # @return [Array<Petitest::TestCase>]
    attr_reader :test_cases

    # @param test_cases [Array<Petitest::TestCase>]
    def initialize(test_cases)
      @test_cases = test_cases
    end

    # @return [Boolean]
    def run
      reporter.before_running_test_cases(test_cases)
      test_cases.each do |test_case|
        reporter.before_running_test_case(test_case)
        test_case.run
        reporter.after_running_test_case(test_case)
      end
      reporter.after_running_test_cases(test_cases)
      test_cases.map(&:error).all?(&:nil?)
    end

    # @todo
    # @return [Petitest::Reporters::BaseReporter]
    def reporter
      @reporter ||= ::Petitest::Reporters::DotReporter.new
    end
  end
end
