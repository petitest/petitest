module Petitest
  module SubscriberConcerns
    module OutputConcern
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

      private

      # @return [IO]
      def output
        ::Petitest.configuration.output
      end
    end
  end
end
