require "petitest/subscribers/base_subscriber"
require "petitest/subscriber_concerns/output_concern"
require "petitest/subscriber_concerns/time_concern"

module Petitest
  module Subscribers
    class ProgressReportSubscriber < ::Petitest::Subscribers::BaseSubscriber
      include ::Petitest::SubscriberConcerns::OutputConcern
      include ::Petitest::SubscriberConcerns::TimeConcern

      # @note Override
      def after_running_test_case(test_case)
        super
        string = ::Petitest::Texts::TestCaseResultCharacterText.new(test_case: test_case).to_s
        output.print(string)
      end

      # @note Override
      def after_running_test_cases(test_cases)
        super
        string = ::Petitest::Texts::TestCasesResultText.new(
          finished_at: finished_at,
          started_at: started_at,
          test_cases: test_cases,
        ).to_s
        output.puts(string)
      end
    end
  end
end
