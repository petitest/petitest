module Petitest
  class TestRunner
    # @return [StandardError, nil]
    attr_accessor :error

    # @return [Time, nil]
    attr_accessor :finished_at

    # @return [Time, nil]
    attr_accessor :started_at

    # @return [Petitest::Test]
    attr_reader :test

    # @return [Petitest::TestGroup]
    attr_reader :test_group

    # @return [Symbol]
    attr_reader :test_method_name

    # @param test [Petitest::Test]
    # @param test_group [Petitest::TestGroup]
    # @param test_method_name [Symbol]
    def initialize(
      test:,
      test_group:,
      test_method_name:
    )
      @duration = nil
      @processed = false
      @test = test
      @test_group = test_group
      @test_method_name = test_method_name
    end

    # @return [Array<String>, nil]
    def backtrace
      if error
        error.backtrace
      end
    end

    # @return [String]
    def description
      test.class.description_by_method_name[test_method_name] || "##{test_method_name}"
    end

    # @return [String]
    def full_description
      [
        test_group.full_description,
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
      processed? && !skipped? && !error.nil?
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

    # @note Override
    def inspect
      "#<#{self.class}>"
    end

    # @return [Boolean]
    def passed?
      processed? && !skipped? && !failed?
    end

    # @return [Boolean]
    def processed?
      @processed
    end

    def run
      self.started_at = ::Time.now
      test.send(test_method_name)
      true
    rescue => error
      self.error = error
      false
    ensure
      @finished_at = ::Time.now
      @processed = true
    end

    # @return [Boolean]
    def skipped?
      processed? && error.is_a?(::Petitest::AssertionSkipError)
    end

    # @return [Petitest::TestMethod]
    def test_method
      @test_method ||= begin
        source_location = test.public_method(test_method_name).source_location
        ::Petitest::TestMethod.new(
          line_number: source_location[0],
          method_name: test_method_name,
          path: source_location[1],
        )
      end
    end
  end
end
