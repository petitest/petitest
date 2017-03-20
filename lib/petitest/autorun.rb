require "petitest"

at_exit do
  test_cases = Petitest::TestGroup.test_cases
  result = Petitest::TestCasesRunner.new(test_cases).run
  exit_code = result ? 0 : 1
  exit(exit_code)
end
