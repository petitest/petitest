require "petitest/subscribers/base_subscriber"
require "time"

module Petitest
  module Subscribers
    class TimerSubscriber < ::Petitest::Subscribers::BaseSubscriber
      # @return [Time, nil]
      attr_accessor :finished_at

      # @return [Time, nil]
      attr_accessor :started_at

      # @note Override
      def after_running_test_cases(test_cases)
        super
        self.finished_at = ::Time.now
      end

      # @note Override
      def before_running_test_cases(test_cases)
        super
        self.started_at = ::Time.now
      end
    end
  end
end
