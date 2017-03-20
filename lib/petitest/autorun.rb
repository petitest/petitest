require "petitest"

at_exit do
  test_cases = Petitest::TestCasesCollector.singleton.collect
  result = Petitest::TestCasesRunner.new(test_cases).run
  exit_code = result ? 0 : 1
  exit(exit_code)
end
