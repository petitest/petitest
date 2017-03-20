require "petitest/autorun"

class PetitestTest < Petitest::TestGroup
  def test_nothing1
    assert(true)
  end

  def test_nothing2
    assert(true)
  end

  def test_nothing3
    assert(false)
  end
end
