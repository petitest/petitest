require "petitest"

at_exit do
  test_cases = Petitest::TestCasesCollector.singleton.collect
  result = Petitest::TestCasesRunner.new(test_cases).run
  exit_code = begin
    if result
      0
    else
      1
    end
  end
  exit(exit_code)
end
