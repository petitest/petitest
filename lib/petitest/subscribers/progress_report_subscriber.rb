require "petitest/subscribers/timer_subscriber"

module Petitest
  module Subscribers
    class ProgressReportSubscriber < ::Petitest::Subscribers::TimerSubscriber
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
          case
          when test_case.aborted?
            "E"
          when test_case.failed?
            "F"
          when test_case.skipped?
            "*"
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
            times_section,
            counts_section,
          ].join("\n\n")
        end

        private

        # @return [Integer]
        def count_of_aborted_test_cases
          test_cases.select(&:aborted?).length
        end

        # @return [Integer]
        def count_of_failed_test_cases
          test_cases.select(&:failed?).length
        end

        # @return [Integer]
        def count_of_skipped_test_cases
          test_cases.select(&:skipped?).length
        end

        # @return [Integer]
        def count_of_test_cases
          test_cases.length
        end

        # @return [String]
        def counts_body
          [
            "%6d tests" % count_of_test_cases,
            "%6d falures" % count_of_failed_test_cases,
            "%6d errors" % count_of_aborted_test_cases,
            "%6d skips" % count_of_skipped_test_cases,
          ].join("\n")
        end

        # @return [String]
        def counts_heading
          "Counts:"
        end

        # @return [String]
        def counts_section
          [
            counts_heading,
            indent(counts_body, 2),
          ].join("\n\n")
        end

        # @return [String]
        def failures_body
          test_cases.select(&:failed?).map.with_index do |test_case, index|
            number = index + 1
            failure_heading = "#{number}) #{test_case.failure_message}"
            failure_body = test_case.filtered_backtrace.join("\n").gsub(/^/, "# ")
            [
              failure_heading,
              indent(failure_body, 2),
            ].join("\n")
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
            indent(failures_body, 2),
          ].join("\n\n")
        end

        # @param string [String]
        # @param level [Integer]
        # @return [String]
        def indent(string, level)
          string.gsub(/^(?!$)/, " " * level)
        end

        # @return [String]
        def times_body
          [
            "Started:  #{started_at.iso8601(3)}",
            "Finished: #{finished_at.iso8601(3)}",
            "Total:    %.6fs" % (finished_at - started_at),
          ].join("\n")
        end

        # @return [String]
        def times_heading
          "Times:"
        end

        # @return [String]
        def times_section
          [
            times_heading,
            indent(times_body, 2),
          ].join("\n\n")
        end
      end
    end
  end
end
