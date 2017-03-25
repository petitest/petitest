require "petitest"

at_exit do
  if $! && !($!.is_a?(::SystemExit) && $!.success?)
    next
  end
  test_classes = Petitest::Test.children
  test_plan = Petitest::TestPlan.new(test_classes: test_classes)
  test_plan.run
  exit_code = test_plan.passed? ? 0 : 1
  exit(exit_code)
end
