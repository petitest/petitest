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
          header,
          body,
        ].join
      end

      private

      # @return [String]
      def body
        texts = []
        texts << ::Petitest::Texts::FailuresText.new(test_cases: test_cases_failed) unless test_cases_failed.empty?
        texts << ::Petitest::Texts::ErrorsText.new(test_cases: test_cases_aborted) unless test_cases_aborted.empty?
        texts << ::Petitest::Texts::TestCountsText.new(test_cases: test_cases)
        texts << ::Petitest::Texts::TimesText.new(
          finished_at: finished_at,
          started_at: started_at,
        )
        texts.join("\n\n")
      end

      # @return [String]
      def header
        ::Petitest::Texts::TestCasesResultMarginTopText.new(test_cases: test_cases).to_s
      end

      # @return [Array<Petitest::TestCase>]
      def test_cases_aborted
        @test_cases_aborted ||= test_cases.select(&:aborted?)
      end

      # @return [Array<Petitest::TestCase>]
      def test_cases_failed
        @test_cases_failed ||= test_cases.select(&:failed?)
      end
    end
  end
end
