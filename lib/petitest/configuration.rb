module Petitest
  class Configuration
    DEFAULT_COLOR_SCHEME = {
      detail: :cyan,
      error: :red,
      failure: :red,
      pass: :green,
      skip: :yellow,
    }

    attr_writer :color_scheme
    attr_writer :color
    attr_writer :subscribers

    # @return [Hash{Symbol => Symbol}]
    def color_scheme
      @color_scheme ||= DEFAULT_COLOR_SCHEME.dup
    end

    # @return [Boolean]
    def color
      true
    end

    # @return [Array<Petitest::Subscribers::BaseSubscriber>]
    def subscribers
      @subscribers ||= [::Petitest::Subscribers::ProgressReportSubscriber.new]
    end
  end
end
