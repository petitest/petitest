module Petitest
  class TestCase
    # @return [StandardError, nil]
    attr_accessor :error

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
      @processed = false
      @test_group_class = test_group_class
      @test_method = test_method
    end

    # @return [String, nil]
    def failure_message
      if failed?
        error.to_s
      end
    end

    # @return [Boolean]
    def failed?
      processed? && !error.nil?
    end

    # @return [Boolean]
    def failed_by_assertion?
      failed? && error.is_a?(::Petitest::AssertionFailureError)
    end

    # @return [Boolean]
    def passed?
      processed? && error.nil?
    end

    # @return [Boolean]
    def processed?
      @processed
    end

    def run
      test_group_class.new.send(test_method.method_name)
      true
    rescue => error
      self.error = error
      false
    ensure
      @processed = true
    end
  end
end
