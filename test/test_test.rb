require "petitest/autorun"
require "petitest/power_assert"

class TestTest < Petitest::Test
  prepend ::Petitest::PowerAssert

  def test_assertion_with_truthy_block_to_pass
    assert do
      true
    end
  end

  def test_assertion_with_truthy_value_to_pass
    assert(true)
  end
end
