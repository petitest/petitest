require "petitest/texts/base_text"

module Petitest
  module Texts
    class TestCountsText < ::Petitest::Texts::BaseText
      # @return [Array<Petitest::TestCase>]
      attr_reader :test_cases

      # @param test_cases [Array<Petitest::TestCase>]
      def initialize(test_cases:)
        @test_cases = test_cases
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
          text_of_count_of_test_cases,
          text_of_count_of_passed_test_cases,
          text_of_count_of_failed_test_cases,
          text_of_count_of_aborted_test_cases,
          text_of_count_of_skipped_test_cases,
        ].join("\n")
      end

      # @return [Integer]
      def count_of_aborted_test_cases
        test_cases.select(&:aborted?).length
      end

      # @return [Integer]
      def count_of_failed_test_cases
        test_cases.select(&:failed?).length
      end

      # @return [Integer]
      def count_of_passed_test_cases
        test_cases.select(&:passed?).length
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
      def heading
        "Counts:"
      end

      # @return [Integer]
      def max_digits_length
        @max_digits_length ||= count_of_test_cases.to_s.length
      end

      # @return [String]
      def text_of_count_of_aborted_test_cases
        colorize("%#{max_digits_length}d errors" % count_of_aborted_test_cases, :error)
      end

      # @return [String]
      def text_of_count_of_failed_test_cases
        colorize("%#{max_digits_length}d failures" % count_of_failed_test_cases, :failure)
      end

      # @return [String]
      def text_of_count_of_passed_test_cases
        colorize("%#{max_digits_length}d passes" % count_of_passed_test_cases, :pass)
      end

      # @return [String]
      def text_of_count_of_skipped_test_cases
        colorize("%#{max_digits_length}d skips" % count_of_skipped_test_cases, :skip)
      end

      # @return [String]
      def text_of_count_of_test_cases
        "%#{max_digits_length}d tests" % count_of_test_cases
      end
    end
  end
end
