require "petitest/texts/base_text"

module Petitest
  module Texts
    class ErrorMessageText < ::Petitest::Texts::BaseText
      # @return [Petitest::TestCase]
      attr_reader :test_case

      # @param test_case [Petitest::TestCase]
      def initialize(test_case:)
        @test_case = test_case
      end

      # @note Override
      def to_s
        elements = []
        elements << test_case.error_class_name unless test_case.error.is_a?(::Petitest::AssertionFailureError)
        elements << test_case.error_message
        string = elements.join("\n")
        colorize(string, :error)
      end
    end
  end
end
