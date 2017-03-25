require "petitest/texts/base_text"

module Petitest
  module Texts
    class TestResultCharacterText < ::Petitest::Texts::BaseText
      # @return [Petitest::Test]
      attr_reader :test

      # @param test [Petitest::Test]
      def initialize(test:)
        @test = test
      end

      # @note Override
      def to_s
        case
        when test.runner.failed?
          colorize("F", :error)
        when test.runner.skipped?
          colorize("*", :skip)
        else
          "."
        end
      end
    end
  end
end
