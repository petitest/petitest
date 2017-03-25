module Petitest
  class TestPlan
    # @return [Array<Class>]
    attr_reader :test_classes

    # @param test_classes [Array<Class>]
    def initialize(test_classes:)
      @test_classes = test_classes
    end

    # @return [Boolean]
    def passed?
      tests.map(&:runner).all? do |runner|
        runner.passed? || runner.skipped?
      end
    end

    def run
      before_running_test_plan
      test_groups.each do |test_group|
        run_test_group(test_group)
      end
      after_running_test_plan
    end

    # @return [Array<Petitest::TestGroup>]
    def test_groups
      @test_groups ||= test_classes.map(&:generate_test_group)
    end

    # @return [Array<Petitest::Test>]
    def tests
      test_groups.flat_map(&:self_and_descendant_tests)
    end

    private

    # @param test [Petitest::Test]
    def after_running_test(test)
      subscribers.each do |subscriber|
        subscriber.after_running_test(test)
      end
    end

    # @param test_group [Petitest::TestGroup]
    def after_running_test_group(test_group)
      subscribers.each do |subscriber|
        subscriber.after_running_test_group(test_group)
      end
    end

    def after_running_test_plan
      subscribers.each do |subscriber|
        subscriber.after_running_test_plan(self)
      end
    end

    # @param test [Petitest::Test]
    def before_running_test(test)
      subscribers.each do |subscriber|
        subscriber.before_running_test(test)
      end
    end

    # @param test_group [Petitest::TestGroup]
    def before_running_test_group(test_group)
      subscribers.each do |subscriber|
        subscriber.before_running_test_group(test_group)
      end
    end

    def before_running_test_plan
      subscribers.each do |subscriber|
        subscriber.before_running_test_plan(self)
      end
    end

    # @param test [Petitest::Test]
    def run_test(test)
      before_running_test(test)
      test.runner.run
      after_running_test(test)
    end

    # @param test_group [Petitest::TestGroup]
    def run_test_group(test_group)
      before_running_test_group(test_group)
      test_group.tests.each do |test|
        run_test(test)
      end
      test_group.sub_test_groups.each do |sub_test_group|
        run_test_group(sub_test_group)
      end
      after_running_test_group(test_group)
    end

    # @return [Array<Petitest::Subscribers::BaseSubscriber>]
    def subscribers
      ::Petitest.configuration.subscribers
    end
  end
end
