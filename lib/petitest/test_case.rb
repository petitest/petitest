module Petitest
  class TestCase
    # @return [StandardError, nil]
    attr_accessor :error

    # @return [Class]
    attr_reader :test_group_class

    # @return [Petitest::TestMethod]
    attr_reader :test_method

    class << self
      # @return [String]
      def prefix_to_filter_backtrace
        @prefix_to_filter_backtrace ||= ::File.expand_path("../..", __FILE__)
      end
    end

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

    # @return [Boolean]
    def aborted?
      processed? && has_error? && !has_assertion_error?
    end

    # @return [Array<String>, nil]
    def backtrace
      if failed?
        error.backtrace
      end
    end

    # @return [String, nil]
    def failure_message
      if failed?
        error.to_s
      end
    end

    # @return [Boolean]
    def failed?
      processed? && has_assertion_error?
    end

    # @return [Array<String>, nil]
    def filtered_backtrace
      backtrace.reject do |line|
        line.start_with?(self.class.prefix_to_filter_backtrace)
      end
    end

    # @return [Boolean]
    def has_assertion_error?
      error.is_a?(::Petitest::AssertionFailureError)
    end

    # @return [Boolean]
    def has_error?
      !error.nil?
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

    # @todo
    # @return [Boolean]
    def skipped?
      false
    end
  end
end
