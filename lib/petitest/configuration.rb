module Petitest
  class Configuration
    DEFAULT_COLOR_SCHEME = {
      detail: :cyan,
      error: :red,
      failure: :red,
      pass: :green,
      skip: :yellow,
    }

    # @return [Array<String>]
    attr_accessor :backtrace_filters

    # @return [Hash{Symbol => Symbol}]
    attr_accessor :color_scheme

    # @return [Boolean]
    attr_accessor :color

    # @return [IO]
    attr_accessor :output

    # @return [Array<Petitest::Subscribers::BaseSubscriber>]
    attr_accessor :subscribers

    def initialize
      @backtrace_filters = [::File.expand_path("../..", __FILE__)]
      @color_scheme = DEFAULT_COLOR_SCHEME.dup
      @color = true
      @output = ::STDOUT
      @output.sync = true
      @subscribers = [::Petitest::Subscribers::ProgressReportSubscriber.new]
    end
  end
end
