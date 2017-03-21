require "json"
require "petitest/subscribers/timer_subscriber"
require "time"

module Petitest
  module Subscribers
    class JsonReportSubscriber < ::Petitest::Subscribers::TimerSubscriber
      # @note Override
      def after_running_test_cases(test_cases)
        super
        data = {
          statistics: {
            finished_at: finished_at.iso8601(6),
            started_at: started_at.iso8601(6),
          },
          test_cases: test_cases.map do |test_case|
            {
              class_name: test_case.test_group_class.to_s,
              failed: test_case.failed?,
              failure_message: test_case.failure_message,
              line_number: test_case.test_method.line_number,
              method_name: test_case.test_method.method_name,
              path: test_case.test_method.path,
            }
          end,
        }
        output = ::JSON.pretty_generate(data)
        puts output
      end
    end
  end
end
