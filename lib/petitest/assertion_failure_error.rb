module Petitest
  class AssertionFailureError < ::StandardError
    # @return [String, nil]
    attr_reader :additional_message

    # @return [String]
    attr_reader :template

    # @return [Hash{Symbol => Object}]
    attr_reader :template_variables

    # @param additional_message [String, nil]
    # @param template [String]
    # @param template_variables [Hash, nil]
    def initialize(
      additional_message:,
      template:,
      template_variables:
    )
      @additional_message = additional_message
      @template = template
      @template_variables = template_variables
      super(assertion_type_message)
    end

    # @return [String]
    def assertion_type_message
      template % inspected_template_variables
    end

    private

    # @return [Hash{Symbol => String}]
    def inspected_template_variables
      template_variables.map do |key, value|
        [key, value.inspect]
      end.to_h
    end
  end
end
