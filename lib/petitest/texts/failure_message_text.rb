require "petitest/texts/base_text"

module Petitest
  module Texts
    class FailureMessageText < ::Petitest::Texts::BaseText
      # @return [Petitest::TestCase]
      attr_reader :test_case

      # @param test_case [Petitest::TestCase]
      def initialize(test_case:)
        @test_case = test_case
      end

      # @note Override
      def to_s
        colorize(test_case.failure_message, :failure)
      end
    end
  end
end
