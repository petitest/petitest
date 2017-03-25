require "petitest/texts/base_text"

module Petitest
  module Texts
    class TestsResultMarginTopText < ::Petitest::Texts::BaseText
      # @return [Array<Petitest::Test>]
      attr_reader :tests

      # @param tests [Array<Petitest::Test>]
      def initialize(tests:)
        @tests = tests
      end

      # @note Override
      def to_s
        if tests.empty?
          "\n"
        else
          "\n\n"
        end
      end
    end
  end
end
