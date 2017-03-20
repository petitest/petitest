require "petitest/autorun"

class PetitestTest < Petitest::TestGroup
  def test_nothing
    assert(false)
  end
end
