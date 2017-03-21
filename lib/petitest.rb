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
require "petitest/texts/base_text"
require "petitest/texts/error_message_text"
require "petitest/texts/errors_element_text"
require "petitest/texts/errors_text"
require "petitest/texts/failure_message_text"
require "petitest/texts/failures_element_text"
require "petitest/texts/failures_text"
require "petitest/texts/filtered_backtrace_text"
require "petitest/texts/raised_code_text"
require "petitest/texts/test_case_result_character_text"
require "petitest/texts/test_cases_result_margin_top_text"
require "petitest/texts/test_cases_result_text"
require "petitest/texts/test_counts_text"
require "petitest/texts/times_text"
require "petitest/version"

module Petitest
  class << self
    # @return [Petitest::Configuration]
    def configuration
      @configuration ||= ::Petitest::Configuration.new
    end
  end
end
