require "petitest/autorun"

class PetitestTest < Petitest::TestGroup
  def test_nothing
    assert_equal(true, true)
  end
end
