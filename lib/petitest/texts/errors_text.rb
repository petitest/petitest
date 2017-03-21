require "petitest/texts/base_text"

module Petitest
  module Texts
    class ErrorsText < ::Petitest::Texts::BaseText
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
        errors_element_texts.join("\n\n")
      end

      # @return [Array<Petitest::Textx::FailuresElementText>]
      def errors_element_texts
        test_cases.map.with_index do |test_case, index|
          ::Petitest::Texts::ErrorsElementText.new(
            index: index,
            test_case: test_case,
          )
        end
      end

      # @return [String]
      def heading
        "Errors:"
      end
    end
  end
end
