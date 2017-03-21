require "json"
require "petitest/subscribers/timer_subscriber"

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
              aborted: test_case.aborted?,
              failed: test_case.failed?,
              failure_message: test_case.failure_message,
              skipped: test_case.skipped?,
              test_file_path: test_case.test_method.path,
              test_group_class_name: test_case.test_group_class.to_s,
              test_method_line_number: test_case.test_method.line_number,
              test_method_name: test_case.test_method.method_name,
            }
          end,
        }
        output = ::JSON.pretty_generate(data)
        puts output
      end
    end
  end
end
