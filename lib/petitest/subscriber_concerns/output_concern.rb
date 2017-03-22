module Petitest
  module SubscriberConcerns
    module OutputConcern
      private

      # @return [IO]
      def output
        ::Petitest.configuration.output
      end
    end
  end
end
