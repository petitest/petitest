require "petitest/texts/base_text"

module Petitest
  module Texts
    class TestCountsText < ::Petitest::Texts::BaseText
      # @return [Array<Petitest::Test>]
      attr_reader :tests

      # @param tests [Array<Petitest::Test>]
      def initialize(tests:)
        @tests = tests
      end

      # @note Override
      def to_s
        [
          heading,
          indent(body, 2),
        ].join("\n\n")
      end

      private

      # @return [String]
      def body
        [
          text_of_count_of_tests,
          text_of_count_of_passed_tests,
          text_of_count_of_failed_tests,
          text_of_count_of_skipped_tests,
        ].join("\n")
      end

      # @return [Integer]
      def count_of_failed_tests
        tests.map(&:runner).select(&:failed?).length
      end

      # @return [Integer]
      def count_of_passed_tests
        tests.map(&:runner).select(&:passed?).length
      end

      # @return [Integer]
      def count_of_skipped_tests
        tests.map(&:runner).select(&:skipped?).length
      end

      # @return [Integer]
      def count_of_tests
        tests.length
      end

      # @return [String]
      def heading
        "Counts:"
      end

      # @return [Integer]
      def max_digits_length
        @max_digits_length ||= count_of_tests.to_s.length
      end

      # @return [String]
      def text_of_count_of_failed_tests
        colorize("%#{max_digits_length}d failures" % count_of_failed_tests, :error)
      end

      # @return [String]
      def text_of_count_of_passed_tests
        colorize("%#{max_digits_length}d passes" % count_of_passed_tests, :pass)
      end

      # @return [String]
      def text_of_count_of_skipped_tests
        colorize("%#{max_digits_length}d skips" % count_of_skipped_tests, :skip)
      end

      # @return [String]
      def text_of_count_of_tests
        "%#{max_digits_length}d tests" % count_of_tests
      end
    end
  end
end
