module Petitest
  class TestGroup
    # @return [Class]
    attr_reader :test_class

    # @param test_class [Class]
    def initialize(test_class:)
      @test_class ||= test_class
    end

    # @return [String]
    def description
      test_class.description
    end

    # @return [Hash{Symbol => Object}]
    def metadata
      test_class.metadata
    end

    # @return [Integer]
    def nest_level
      test_class.nest_level
    end

    # @return [Array<Petitest::Test>]
    def self_and_descendant_tests
      tests + sub_test_groups.flat_map(&:self_and_descendant_tests)
    end

    # @return [Array<Petitest::TestGroup>]
    def sub_test_groups
      @sub_test_groups ||= test_class.children.map(&:generate_test_group)
    end

    # @return [Array<Petitest::Test>]
    def tests
      @tests ||= test_class.test_method_names.map do |test_method_name|
        test_class.new(
          test_group: self,
          test_method_name: test_method_name,
        )
      end
    end
  end
end
