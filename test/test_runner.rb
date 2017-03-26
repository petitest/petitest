require "petitest/autorun"
require "petitest/power_assert"

class TestRunner < Petitest::Test
  prepend ::Petitest::PowerAssert

  def test_description
    assert do
      runner.test_group.description == "TestRunner"
    end
  end

  def test_full_description
    assert do
      runner.test_group.full_description == "TestRunner"
    end
  end
end
