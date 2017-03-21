require "petitest/texts/base_text"

module Petitest
  module Texts
    class TestCaseResultCharacterText < ::Petitest::Texts::BaseText
      # @return [Petitest::TestCase]
      attr_reader :test_case

      # @param test_case [Petitest::TestCase]
      def initialize(test_case:)
        @test_case = test_case
      end

      # @note Override
      def to_s
        case
        when test_case.aborted?
          colorize("E", :error)
        when test_case.failed?
          colorize("F", :failure)
        when test_case.skipped?
          colorize("*", :skip)
        else
          "."
        end
      end
    end
  end
end
