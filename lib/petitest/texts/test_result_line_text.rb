require "petitest/texts/base_text"

module Petitest
  module Texts
    class TestResultLineText < ::Petitest::Texts::BaseText
      # @return [Petitest::Test]
      attr_reader :test

      # @param test [Petitest::Test]
      def initialize(test:)
        @test = test
      end

      # @note Override
      def to_s
        indent(
          colorize(test.runner.description, color_type),
          indent_level,
        )
      end

      private

      # @return [Symbol]
      def color_type
        case
        when test.runner.failed?
          :error
        when test.runner.skipped?
          :skip
        else
          :pass
        end
      end

      # @return [Integer]
      def indent_level
        2 * (test.runner.test_group.nest_level + 1)
      end
    end
  end
end
