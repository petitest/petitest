module Petitest
  class TestGroup
    include ::Petitest::Assertions

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

      # @return [Array<String>]
      def test_method_names
        public_instance_methods.map(&:to_s).select do |method_name|
          method_name.start_with?(TEST_METHOD_NAME_PREFIX)
        end
      end

      # @return [Array<Petitest::TestMethod>]
      def test_methods
        test_method_names.map do |method_name|
          unbound_method = public_instance_method(method_name)
          ::Petitest::TestMethod.new(
            line_number: unbound_method.source_location[1],
            method_name: method_name.to_s,
            path: unbound_method.source_location[0],
          )
        end
      end
    end
  end
end
