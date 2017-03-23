module Petitest
  class TestCase
    # @return [StandardError, nil]
    attr_accessor :error

    # @return [Time, nil]
    attr_accessor :finished_at

    # @return [Time, nil]
    attr_accessor :started_at

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
      @duration = nil
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
      if has_error?
        error.backtrace
      end
    end

    # @return [String, nil]
    def error_class_name
      if aborted?
        error.class.to_s
      end
    end

    # @return [String, nil]
    def error_message
      if aborted?
        error.to_s
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
      @filtered_backtrace ||= begin
        path = ::File.expand_path("../test_group.rb", __FILE__)
        backtrace.reverse_each.each_with_object([]) do |line, lines|
          if line.start_with?(path)
            break lines
          end
          unless ::Petitest.configuration.prefixes_to_filter_backtrace.any? { |prefix| line.start_with?(prefix) }
            lines << line
          end
        end.reverse
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
      self.started_at = ::Time.now
      test_group_class.new.send(test_method.method_name)
      true
    rescue => error
      self.error = error
      false
    ensure
      @finished_at = ::Time.now
      @processed = true
    end

    # @todo
    # @return [Boolean]
    def skipped?
      false
    end

    # @return [String]
    def test_signature
      [test_group_class, test_method.method_name].join("#")
    end
  end
end
