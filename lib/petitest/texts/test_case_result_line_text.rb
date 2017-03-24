require "petitest/texts/base_text"

module Petitest
  module Texts
    class TestCaseResultLineText < ::Petitest::Texts::BaseText
      # @return [Petitest::TestCase]
      attr_reader :test_case

      # @param test_case [Petitest::TestCase]
      def initialize(test_case:)
        @test_case = test_case
      end

      # @note Override
      def to_s
        indent(
          colorize("##{test_case.test_method.method_name}", color_type),
          2 * (test_case.test_group_class.nest_level + 1),
        )
      end

      private

      # @return [Symbol]
      def color_type
        case
        when test_case.failed?
          :error
        when test_case.skipped?
          :skip
        else
          :pass
        end
      end
    end
  end
end
