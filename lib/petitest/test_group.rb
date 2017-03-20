module Petitest
  class TestGroup
    TEST_METHOD_NAME_PREFIX = "test_"

    class << self
      # @return [Array<Class>]
      def descendants
        @@descendants ||= []
      end

      # @note Override
      def inherited(sub_class)
        super
        descendants << sub_class
      end

      # @note Override
      def method_added(method_name)
        super
        if method_name.to_s.start_with?(TEST_METHOD_NAME_PREFIX)
          caller_location = caller_locations(1, 1)[0]
          test_methods << ::Petitest::TestMethod.new(
            line_number: caller_location.lineno,
            method_name: method_name.to_s,
            path: ::File.expand_path(caller_location.absolute_path || caller_location.path)
          )
        end
      end

      # @return [Array<Petitest::TestMethod>]
      def test_methods
        @test_methods ||= []
      end
    end
  end
end
