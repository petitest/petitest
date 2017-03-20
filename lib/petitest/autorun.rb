require "petitest"

at_exit do
  Petitest::AutoRunner.singleton.run
end
