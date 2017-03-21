require "json"
require "petitest/subscribers/timer_subscriber"

module Petitest
  module Subscribers
    class JsonReportSubscriber < ::Petitest::Subscribers::TimerSubscriber
      # @note Override
      def after_running_test_cases(test_cases)
        super
        data = {
          test_cases: test_cases.map do |test_case|
            {
              aborted: test_case.aborted?,
              backtrace: test_case.backtrace,
              class_name: test_case.test_group_class.to_s,
              error_class_name: test_case.error_class_name,
              error_message: test_case.error_message,
              failed: test_case.failed?,
              failure_message: test_case.failure_message,
              finished_at: test_case.finished_at.iso8601(6),
              method_line_number: test_case.test_method.line_number,
              method_name: test_case.test_method.method_name,
              path: test_case.test_method.path,
              skipped: test_case.skipped?,
              started_at: test_case.started_at.iso8601(6),
            }
          end,
          times: {
            finished_at: finished_at.iso8601(6),
            started_at: started_at.iso8601(6),
          },
        }
        output = ::JSON.pretty_generate(data)
        puts output
      end
    end
  end
end
