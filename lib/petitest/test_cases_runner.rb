module Petitest
  class TestCasesRunner
    # @return [Array<Class>]
    attr_reader :test_group_classes

    # @param test_group_classes [Array<Class>]
    def initialize(test_group_classes)
      @test_group_classes = test_group_classes
    end

    # @return [Boolean]
    def run
      test_cases = test_group_classes.flat_map(&:test_cases_and_children_test_cases)
      before_running_test_cases(test_cases)
      test_group_classes.each do |test_group_class|
        run_test_group(test_group_class)
      end
      after_running_test_cases(test_cases)
      test_cases.all?(&:passed?)
    end

    private

    # @param test_case [Petitest::TestCase]
    def after_running_test_case(test_case)
      subscribers.each do |subscriber|
        subscriber.after_running_test_case(test_case)
      end
    end

    # @param test_cases [Array<Petitest::TestCase>]
    def after_running_test_cases(test_cases)
      subscribers.each do |subscriber|
        subscriber.after_running_test_cases(test_cases)
      end
    end

    # @param test_group_class [Class]
    def after_running_test_group(test_group_class)
      subscribers.each do |subscriber|
        subscriber.after_running_test_group(test_group_class)
      end
    end

    # @param test_case [Petitest::TestCase]
    def before_running_test_case(test_case)
      subscribers.each do |subscriber|
        subscriber.before_running_test_case(test_case)
      end
    end

    # @param test_cases [Array<Petitest::TestCase>]
    def before_running_test_cases(test_cases)
      subscribers.each do |subscriber|
        subscriber.before_running_test_cases(test_cases)
      end
    end

    # @param test_group_class [Class]
    def before_running_test_group(test_group_class)
      subscribers.each do |subscriber|
        subscriber.before_running_test_group(test_group_class)
      end
    end

    # @param test_case [Petitest::TestCase]
    def run_test_case(test_case)
      before_running_test_case(test_case)
      test_case.run
      after_running_test_case(test_case)
    end

    # @param test_group_class [Class]
    def run_test_group(test_group_class)
      before_running_test_group(test_group_class)
      test_group_class.test_cases.each do |test_case|
        run_test_case(test_case)
      end
      test_group_class.children.each do |child_test_group_class|
        run_test_group(child_test_group_class)
      end
      after_running_test_group(test_group_class)
    end

    # @return [Array<Petitest::Subscribers::BaseSubscriber>]
    def subscribers
      ::Petitest.configuration.subscribers
    end
  end
end
