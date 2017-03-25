require "petitest/autorun"

class SimpleTest < Petitest::Test
  def test_one_plus_one_to_be_two
    assert { 1 + 1 == 2 }
  end
end
