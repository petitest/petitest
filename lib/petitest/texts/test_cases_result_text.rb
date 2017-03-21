require "petitest/texts/base_text"

module Petitest
  module Texts
    class TestCasesResultText < ::Petitest::Texts::BaseText
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
          ::Petitest::Texts::TestCasesResultMarginTopText.new(test_cases: test_cases),
          [
            ::Petitest::Texts::FailuresText.new(test_cases: test_cases.select(&:failed?)),
            ::Petitest::Texts::ErrorsText.new(test_cases: test_cases.select(&:aborted?)),
            ::Petitest::Texts::TestCountsText.new(test_cases: test_cases),
            ::Petitest::Texts::TimesText.new(
              finished_at: finished_at,
              started_at: started_at,
            ),
          ].join("\n\n"),
        ].join
      end
    end
  end
end
