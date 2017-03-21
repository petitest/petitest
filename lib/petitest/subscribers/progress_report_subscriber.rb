require "petitest/subscribers/timer_subscriber"

module Petitest
  module Subscribers
    class ProgressReportSubscriber < ::Petitest::Subscribers::TimerSubscriber
      # @note Override
      def after_running_test_case(test_case)
        super
        print ::Petitest::Texts::TestCaseResultCharacterText.new(test_case: test_case)
      end

      # @note Override
      def after_running_test_cases(test_cases)
        super
        puts ::Petitest::Texts::TestCasesResultText.new(
          finished_at: finished_at,
          started_at: started_at,
          test_cases: test_cases,
        )
      end
    end
  end
end
