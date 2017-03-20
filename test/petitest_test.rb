require "petitest/autorun"

class PetitestTest < Petitest::TestGroup
  def test_empty_string
    assert("")
  end

  def test_false
    assert(false)
  end

  def test_nil
    assert(nil)
  end

  def test_true
    assert(true)
  end

  def test_zero
    assert(0)
  end
end
