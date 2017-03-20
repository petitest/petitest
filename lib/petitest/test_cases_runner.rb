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
      before_running_test_cases(test_cases)
      test_cases.each do |test_case|
        before_running_test_case(test_case)
        test_case.run
        after_running_test_case(test_case)
      end
      after_running_test_cases(test_cases)
      test_cases.all?(&:passed?)
    end

    private

    # @param test_case [Petitest::TestCase]
    def after_running_test_case(test_case)
      subscribers.each do |subscriber|
        subscriber.after_running_test_case(test_case)
      end
    end

    # @param test_cases [Array<Petitest::TestCase>]
    def after_running_test_cases(test_cases)
      subscribers.each do |subscriber|
        subscriber.after_running_test_cases(test_cases)
      end
    end

    # @param test_case [Petitest::TestCase]
    def before_running_test_case(test_case)
      subscribers.each do |subscriber|
        subscriber.before_running_test_case(test_case)
      end
    end

    # @param test_cases [Array<Petitest::TestCase>]
    def before_running_test_cases(test_cases)
      subscribers.each do |subscriber|
        subscriber.before_running_test_cases(test_cases)
      end
    end

    # @return [Array<Petitest::Subscribers::BaseSubscriber>]
    def subscribers
      @subscribers ||= [
        ::Petitest::Subscribers::DotReportSubscriber.new,
      ]
    end
  end
end
