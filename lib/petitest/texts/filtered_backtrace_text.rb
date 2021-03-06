require "petitest/texts/base_text"

module Petitest
  module Texts
    class FilteredBacktraceText < ::Petitest::Texts::BaseText
      # @return [Petitest::Test]
      attr_reader :test

      # @param test [Petitest::Test]
      def initialize(test:)
        @test = test
      end

      # @note Override
      def to_s
        colorize(test.runner.filtered_backtrace.join("\n").gsub(/^/, "# "), :detail)
      end
    end
  end
end
