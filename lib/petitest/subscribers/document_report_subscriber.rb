require "petitest/subscribers/base_subscriber"
require "petitest/subscriber_concerns/output_concern"
require "petitest/subscriber_concerns/time_concern"

module Petitest
  module Subscribers
    class DocumentReportSubscriber < ::Petitest::Subscribers::BaseSubscriber
      include ::Petitest::SubscriberConcerns::OutputConcern
      include ::Petitest::SubscriberConcerns::TimeConcern

      # @note Override
      def after_running_test(test)
        super
        string = ::Petitest::Texts::TestResultLineText.new(test: test).to_s
        output.puts(string)
      end

      # @note Override
      def after_running_test_plan(test_plan)
        super
        string = ::Petitest::Texts::TestsResultText.new(
          finished_at: finished_at,
          started_at: started_at,
          tests: test_plan.tests,
        ).to_s
        output.puts(string)
      end

      # @note Override
      def before_running_test_group(test_group)
        super
        string = "#{'  ' * test_group.nest_level}#{test_group.description}"
        output.puts(string)
      end
    end
  end
end
