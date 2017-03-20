require "petitest"

at_exit do
  result = Petitest::AutoRunner.singleton.run
  exit_code = begin
    if result
      0
    else
      1
    end
  end
  exit(exit_code)
end
