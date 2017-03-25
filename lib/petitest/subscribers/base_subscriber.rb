module Petitest
  module Subscribers
    class BaseSubscriber
      # @param test [Petitest::Test]
      def after_running_test(test)
      end

      # @param test_group [Petitest::TestGroup]
      def after_running_test_group(test_group)
      end

      # @param test_plan [Petitest::TestPlan]
      def after_running_test_plan(test_plan)
      end

      # @param test [Petitest::Test]
      def before_running_test(test)
      end

      # @param test_group [Petitest::TestGroup]
      def before_running_test_group(test_group)
      end

      # @param test_plan [Petitest::TestPlan]
      def before_running_test_plan(test_plan)
      end
    end
  end
end
