module Petitest
  class AutoRunner
    class << self
      # @return [Petitest::AutoRunner]
      def singleton
        @singleton ||= new
      end
    end

    # @return [Boolean]
    def run
      test_cases.each(&:run)
      p test_cases
    end

    # @return [Array<Petitest::TestCase>]
    def test_cases
      @test_cases ||= ::Petitest::TestCaseCollector.new.collect
    end
  end
end
