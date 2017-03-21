module Petitest
  class Configuration
    def subscribers
      @subscribers ||= [::Petitest::Subscribers::ProgressReportSubscriber.new]
    end
  end
end
