require "json"
require "petitest/subscribers/base_subscriber"
require "petitest/subscriber_concerns/output_concern"
require "petitest/subscriber_concerns/time_concern"

module Petitest
  module Subscribers
    class JsonReportSubscriber < ::Petitest::Subscribers::BaseSubscriber
      include ::Petitest::SubscriberConcerns::OutputConcern
      include ::Petitest::SubscriberConcerns::TimeConcern

      # @note Override
      def after_running_test_plan(test_plan)
        super
        data = {
          tests: test_plan.tests.map do |test|
            {
              backtrace: test.runner.backtrace,
              class_name: test.class.to_s,
              error_class_name: test.runner.error_class_name,
              error_message: test.runner.error_message,
              failed: test.runner.failed?,
              finished_at: test.runner.finished_at.iso8601(6),
              full_description: test.runner.full_description,
              method_line_number: test.runner.test_method.line_number,
              method_name: test.runner.test_method.method_name,
              path: test.runner.test_method.path,
              skipped: test.runner.skipped?,
              started_at: test.runner.started_at.iso8601(6),
            }
          end,
          times: {
            finished_at: finished_at.iso8601(6),
            started_at: started_at.iso8601(6),
          },
        }
        string = ::JSON.pretty_generate(data)
        output.puts(string)
      end
    end
  end
end
