require "petitest"

at_exit do
  if $! && !($!.is_a?(::SystemExit) && $!.success?)
    next
  end
  result = Petitest::TestCasesRunner.new(Petitest::TestGroup.children).run
  exit_code = result ? 0 : 1
  exit(exit_code)
end
