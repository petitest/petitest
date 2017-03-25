require "petitest/texts/base_text"

module Petitest
  module Texts
    class ErrorMessageText < ::Petitest::Texts::BaseText
      # @return [Petitest::Test]
      attr_reader :test

      # @param test [Petitest::Test]
      def initialize(test:)
        @test = test
      end

      # @note Override
      def to_s
        elements = []
        elements << test.runner.error_class_name unless test.runner.error.is_a?(::Petitest::AssertionFailureError)
        elements << test.runner.error_message unless test.runner.error_message.empty?
        string = elements.join("\n")
        colorize(string, :error)
      end
    end
  end
end
