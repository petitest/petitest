module Petitest
  class TestMethod
    # @return [Integer]
    attr_reader :line_number

    # @return [String]
    attr_reader :method_name

    # @return [String]
    attr_reader :path

    # @param line_number [Integer]
    # @param method_name [String]
    # @param path [String]
    def initialize(
      line_number:,
      method_name:,
      path:
    )
      @line_number = line_number
      @method_name = method_name
      @path = path
    end
  end
end
