require "petitest"

at_exit do
  if $! && !($!.is_a?(::SystemExit) && $!.success?)
    next
  end
  test_cases = Petitest::TestGroup.test_cases
  result = Petitest::TestCasesRunner.new(test_cases).run
  exit_code = result ? 0 : 1
  exit(exit_code)
end
