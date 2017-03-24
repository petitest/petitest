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

    # @return [Array<String>, nil]
    def backtrace
      if error
        error.backtrace
      end
    end

    # @return [String]
    def description
      @description ||= "##{method_name}"
    end

    # @return [String]
    def full_description
      [
        test_group_class.full_description,
        description,
      ].join(" ")
    end

    # @return [String, nil]
    def error_class_name
      if error
        error.class.to_s
      end
    end

    # @return [String, nil]
    def error_message
      if error
        error.to_s
      end
    end

    # @return [Boolean]
    def failed?
      processed? && !error.nil?
    end

    # @return [Array<String>, nil]
    def filtered_backtrace
      @filtered_backtrace ||= begin
        path = ::File.expand_path("../test_group.rb", __FILE__)
        backtrace.reverse_each.each_with_object([]) do |line, lines|
          if line.start_with?(path)
            break lines
          end
          unless ::Petitest.configuration.backtrace_filters.any? { |filter| filter === line }
            lines << line
          end
        end.reverse
      end
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
