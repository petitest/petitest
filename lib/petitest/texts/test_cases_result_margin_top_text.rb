require "petitest/texts/base_text"

module Petitest
  module Texts
    class TestCasesResultMarginTopText < ::Petitest::Texts::BaseText
      # @return [Array<Petitest::TestCase>]
      attr_reader :test_cases

      # @param test_cases [Array<Petitest::TestCase>]
      def initialize(test_cases:)
        @test_cases = test_cases
      end

      # @note Override
      def to_s
        if test_cases.empty?
          "\n"
        else
          "\n\n"
        end
      end
    end
  end
end
