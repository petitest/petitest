module Petitest
  class Configuration
    attr_writer :backtrace_filters

    attr_writer :color

    attr_writer :color_scheme

    attr_writer :output

    attr_writer :subscribers

    # @return [Array<String>]
    def backtrace_filters
      @backtrace_filters ||= begin
        path = ::File.expand_path("../..", __FILE__)
        [-> (line) { line.start_with?(path) }]
      end
    end

    # @return [Boolean]
    def color
      @color ||= true
    end

    # @return [Hash{Symbol => Symbol}]
    def color_scheme
      @color_scheme ||= {
        detail: :cyan,
        error: :red,
        failure: :red,
        pass: :green,
        skip: :yellow,
      }
    end

    # @return [IO]
    def output
      @output ||= ::STDOUT.tap do |io|
        io.sync = true
      end
    end

    # @return [Array<Petitest::Subscribers::BaseSubscriber>]
    def subscribers
      @subscribers ||= [::Petitest::Subscribers::ProgressReportSubscriber.new]
    end
  end
end
