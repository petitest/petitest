module Petitest
  class AssertionFailureMessage
    # @return [String]
    attr_reader :template

    # @return [Hash{Symbol => Object}]
    attr_reader :template_variables

    # @return [String, nil]
    attr_reader :user_specified_message

    # @param template [String]
    # @param template_variables [Hash{Symbol => Object}]
    # @param user_specified_message [String, nil]
    def initialize(template:, template_variables: {}, user_specified_message:)
      @template = template
      @template_variables = template_variables
      @user_specified_message = user_specified_message
    end

    # @note Override
    def to_s
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
