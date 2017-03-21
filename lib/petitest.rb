require "petitest/assertion_failure_error"
require "petitest/assertion_failure_message"
require "petitest/assertions"
require "petitest/configuration"
require "petitest/subscribers/base_subscriber"
require "petitest/subscribers/json_report_subscriber"
require "petitest/subscribers/progress_report_subscriber"
require "petitest/subscribers/timer_subscriber"
require "petitest/test_case"
require "petitest/test_cases_runner"
require "petitest/test_group"
require "petitest/test_method"
require "petitest/version"

module Petitest
  class << self
    # @return [Petitest::Configuration]
    def configuration
      @configuration ||= ::Petitest::Configuration.new
    end
  end
end
