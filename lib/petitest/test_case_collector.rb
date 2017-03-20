module Petitest
  class TestCaseCollector
    TEST_FILES_PATH_PATTERN = "test/**/*_test.rb"

    # @return [Array<Petit::TestCase]
    def collect
      # require_test_files
      ::Petitest::TestGroup.descendants.flat_map do |test_group_class|
        test_group_class.test_methods.map do |test_method|
          ::Petitest::TestCase.new(
            test_group_class: test_group_class,
            test_method: test_method,
          )
        end
      end
    end

    private

    # @return [Array<String>]
    def collect_test_file_paths
      ::Dir.glob(TEST_FILES_PATH_PATTERN)
    end

    def require_test_files
      collect_test_file_paths.each do |path|
        require ::File.expand_path(path)
      end
    end
  end
end
