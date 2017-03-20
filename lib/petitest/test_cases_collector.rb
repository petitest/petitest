module Petitest
  class TestCasesCollector
    class << self
      def singleton
        @singleton ||= new
      end
    end

    # @return [Array<Petit::TestCase]
    def collect
      ::Petitest::TestGroup.descendants.flat_map do |test_group_class|
        test_group_class.test_methods.map do |test_method|
          ::Petitest::TestCase.new(
            test_group_class: test_group_class,
            test_method: test_method,
          )
        end
      end
    end
  end
end
