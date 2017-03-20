module Petitest
  class TestCasesRunner
    class << self
      # @return [Petitest::TestCasesRunner]
      def singleton
        @singleton ||= new
      end
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
    end

    # @todo
    # @return [Petitest::Reporters::BaseReporter]
    def reporter
      @reporter ||= ::Petitest::Reporters::DotReporter.new
    end

    # @return [Array<Petitest::TestCase>]
    def test_cases
      @test_cases ||= ::Petitest::TestCaseCollector.singleton.collect
    end
  end
end
