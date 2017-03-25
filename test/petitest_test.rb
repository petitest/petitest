require "petitest/autorun"
require "petitest/power_assert"

class PetitestTest < Petitest::Test
  extend ::Petitest::DSL
  prepend ::Petitest::PowerAssert

  def test_assertion_with_truthy_block_to_pass
    assert do
      true
    end
  end

  def test_assertion_with_truthy_value_to_pass
    assert(true)
  end

  def test_description
    assert do
      runner.test_group.description == "PetitestTest"
    end
  end

  def test_full_description
    assert do
      runner.test_group.full_description == "PetitestTest"
    end
  end
end
