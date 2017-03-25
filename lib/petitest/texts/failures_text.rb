require "petitest/texts/base_text"

module Petitest
  module Texts
    class FailuresText < ::Petitest::Texts::BaseText
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
        failures_element_texts.join("\n\n")
      end

      # @return [Array<Petitest::Textx::FailuresElementText>]
      def failures_element_texts
        tests.map.with_index do |test, index|
          ::Petitest::Texts::FailuresElementText.new(
            index: index,
            test: test,
          )
        end
      end

      # @return [String]
      def heading
        "Failures:"
      end
    end
  end
end
