require "petitest/texts/base_text"

module Petitest
  module Texts
    class TestsResultText < ::Petitest::Texts::BaseText
      # @return [Time]
      attr_reader :finished_at

      # @return [Time]
      attr_reader :started_at

      # @return [Array<Petitest::Test>]
      attr_reader :tests

      # @param finished_at [Time]
      # @param started_at [Time]
      # @param tests [Array<Petitest::Test>]
      def initialize(
        finished_at:,
        started_at:,
        tests:
      )
        @finished_at = finished_at
        @started_at = started_at
        @tests = tests
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
        texts << ::Petitest::Texts::FailuresText.new(tests: tests_failed) unless tests_failed.empty?
        texts << ::Petitest::Texts::TestCountsText.new(tests: tests)
        texts << ::Petitest::Texts::TimesText.new(
          finished_at: finished_at,
          started_at: started_at,
        )
        texts.join("\n\n")
      end

      # @return [String]
      def header
        ::Petitest::Texts::TestsResultMarginTopText.new(tests: tests).to_s
      end

      # @return [Array<Petitest::Test>]
      def tests_failed
        @tests_failed ||= tests.select do |test|
          test.runner.failed?
        end
      end
    end
  end
end
