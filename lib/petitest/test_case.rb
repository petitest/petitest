module Petitest
  class TestCase
    # @return [Class]
    attr_reader :test_group_class

    # @return [Petitest::TestMethod]
    attr_reader :test_method

    # @param test_group_class [Class]
    # @param test_method [Petitest::TestMethod]
    def initialize(
      test_group_class:,
      test_method:
    )
      @test_group_class = test_group_class
      @test_method = test_method
    end

    def run
      test_group_class.new.send(test_method.method_name)
    end
  end
end
