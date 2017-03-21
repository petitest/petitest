require "petitest/texts/base_text"

module Petitest
  module Texts
    class FailuresElementText < ::Petitest::Texts::BaseText
      # @return [Integer]
      attr_reader :index

      # @return [Petitest::TestCase]
      attr_reader :test_case

      # @param index [Integer]
      # @param test_case [Petitest::TestCase]
      def initialize(index:, test_case:)
        @index = index
        @test_case = test_case
      end

      # @note Override
      def to_s
        [
          heading,
          indent(body, 2)
        ].join("\n")
      end

      private

      # @return [String]
      def body
        [
          ::Petitest::Texts::RaisedCodeText.new(test_case: test_case),
          ::Petitest::Texts::FailureMessageText.new(test_case: test_case),
          ::Petitest::Texts::FilteredBacktraceText.new(test_case: test_case),
        ].join("\n")
      end

      # @return [String]
      def heading
        "#{ordinal_number}) #{test_signature}"
      end

      # @return [Integer]
      def ordinal_number
        index + 1
      end

      # @return [String]
      def test_signature
        test_case.test_signature
      end
    end
  end
end
