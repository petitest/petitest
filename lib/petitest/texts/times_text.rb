require "petitest/texts/base_text"

module Petitest
  module Texts
    class TimesText < ::Petitest::Texts::BaseText
      # @return [Time]
      attr_reader :finished_at

      # @return [Time]
      attr_reader :started_at

      # @param finished_at [Time]
      # @param started_at [Time]
      def initialize(
        finished_at:,
        started_at:
      )
        @finished_at = finished_at
        @started_at = started_at
      end

      # @note Override
      def to_s
        [
          heading,
          indent(body, 2),
        ].join("\n\n")
      end

      private

      # @return [String]
      def body
        [
          "Started:  #{started_at.iso8601(6)}",
          "Finished: #{finished_at.iso8601(6)}",
          "Total:    %.6fs" % (finished_at - started_at),
        ].join("\n")
      end

      # @return [String]
      def heading
        "Times:"
      end
    end
  end
end
