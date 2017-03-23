require "petitest/texts/base_text"

module Petitest
  module Texts
    class RaisedCodeText < ::Petitest::Texts::BaseText
      # @return [Petitest::TestCase]
      attr_reader :test_case

      # @param test_case [Petitest::TestCase]
      def initialize(test_case:)
        @test_case = test_case
      end

      # @note Override
      def to_s
        if content = caller_file_content
          content.lines[caller_line_number - 1].strip
        else
          ""
        end
      end

      private

      # @return [String, nil]
      def caller_file_content
        if caller_path && ::FileTest.file?(caller_path)
          ::File.read(caller_path)
        end
      end

      # @return [String, nil]
      def caller_line_number
        if caller_segments[1]
          caller_segments[1].to_i
        end
      end

      # @return [String, nil]
      def caller_path
        caller_segments[0]
      end

      # @return [Array<String>]
      def caller_segments
        @caller_segments ||= begin
          if test_case.filtered_backtrace[0]
            test_case.filtered_backtrace[0].split(":", 3)
          else
            []
          end
        end
      end
    end
  end
end
