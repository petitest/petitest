require "petitest/texts/base_text"

module Petitest
  module Texts
    class FailuresElementText < ::Petitest::Texts::BaseText
      # @return [Integer]
      attr_reader :index

      # @return [Petitest::Test]
      attr_reader :test

      # @param index [Integer]
      # @param test [Petitest::Test]
      def initialize(index:, test:)
        @index = index
        @test = test
      end

      # @note Override
      def to_s
        [
          heading,
          indent(body, 2)
        ].join("\n")
      end

      private

      # @return [String]
      def body
        [
          ::Petitest::Texts::RaisedCodeText.new(test: test),
          ::Petitest::Texts::ErrorMessageText.new(test: test),
          ::Petitest::Texts::FilteredBacktraceText.new(test: test),
        ].join("\n")
      end

      # @return [String]
      def heading
        "#{ordinal_number}) #{test.runner.full_description}"
      end

      # @return [Integer]
      def ordinal_number
        index + 1
      end
    end
  end
end
