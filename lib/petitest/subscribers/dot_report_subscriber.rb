require "petitest/subscribers/timer_subscriber"

module Petitest
  module Subscribers
    class DotReportSubscriber < ::Petitest::Subscribers::TimerSubscriber
      # @note Override
      def after_running_test_case(test_case)
        super
        print TestCaseResultReport.new(test_case)
      end

      # @note Override
      def after_running_test_cases(test_cases)
        super
        if test_cases.any?
          puts "\n\n"
        end
        puts TestCasesResultReport.new(
          finished_at: finished_at,
          started_at: started_at,
          test_cases: test_cases,
        )
      end

      class TestCaseResultReport
        # @return [Petitest::TestCase]
        attr_reader :test_case

        # @param test_case [Petitest::TestCase]
        def initialize(test_case)
          @test_case = test_case
        end

        # @note Override
        def to_s
          if test_case.failed?
            "F"
          else
            "."
          end
        end
      end

      class TestCasesResultReport
        # @return [Time]
        attr_reader :finished_at

        # @return [Time]
        attr_reader :started_at

        # @return [Array<Petitest::TestCase>]
        attr_reader :test_cases

        class << self
          # @return [String]
          def prefix_to_filter_backtrace
            @prefix_to_filter_backtrace ||= ::File.expand_path("../../..", __FILE__)
          end
        end

        # @param finished_at [Time]
        # @param started_at [Time]
        # @param test_cases [Array<Petitest::TestCase>]
        def initialize(
          finished_at:,
          started_at:,
          test_cases:
        )
          @finished_at = finished_at
          @started_at = started_at
          @test_cases = test_cases
        end

        # @note Override
        def to_s
          [
            failures_section,
            time_section,
            statistics_section,
          ].join("\n\n")
        end

        private

        # @return [String]
        def failures_body
          test_cases.select(&:failed?).map.with_index do |test_case, index|
            number = index + 1
            failure_message = test_case.error.to_s
            filtered_backtrace = test_case.error.backtrace.reject do |line|
              line.start_with?(self.class.prefix_to_filter_backtrace)
            end
            backtrace = filtered_backtrace.join("\n").gsub(/^/, "# ")
            indent("#{number}) #{failure_message}\n#{indent(backtrace, 2)}", 2)
          end.join("\n\n")
        end

        # @return [String]
        def failures_heading
          "Failures:"
        end

        # @return [String]
        def failures_section
          [
            failures_heading,
            failures_body,
          ].join("\n\n")
        end

        # @param string [String]
        # @param level [Integer]
        # @return [String]
        def indent(string, level)
          string.gsub(/^(?!$)/, " " * level)
        end

        # @return [String]
        def statistics_section
          [
            "#{test_cases.length} tests",
            "#{test_cases.select(&:failed?).length} falures",
          ].join(", ")
        end

        def time_section
          [
            "Started:  #{started_at}",
            "Finished: #{finished_at}",
            "Total:    %.3fs" % (finished_at - started_at),
          ].join("\n")
        end
      end
    end
  end
end
