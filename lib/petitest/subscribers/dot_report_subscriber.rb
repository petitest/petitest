require "petitest/subscribers/base_subscriber"

module Petitest
  module Subscribers
    class DotReportSubscriber < ::Petitest::Subscribers::BaseSubscriber
      # @note Override
      def after_running_test_case(test_case)
        print TestCaseResultReport.new(test_case)
      end

      # @note Override
      def after_running_test_cases(test_cases)
        if test_cases.any?
          puts "\n\n"
        end
        puts TestCasesResultReport.new(test_cases)
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
        # @return [Array<Petitest::TestCase>]
        attr_reader :test_cases

        # @param test_cases [Array<Petitest::TestCase>]
        def initialize(test_cases)
          @test_cases = test_cases
        end

        # @note Override
        def to_s
          [failures_section, statistics_section].join("\n\n")
        end

        private

        def failures_body
          test_cases.select(&:failed?).map.with_index do |test_case, index|
            indent("#{index + 1}) #{test_case.error}", 2)
          end.join("\n\n")
        end

        # @return [String]
        def failures_heading
          "Failures:"
        end

        # @return [String]
        def failures_section
          [failures_heading, failures_body].join("\n\n")
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
      end
    end
  end
end
