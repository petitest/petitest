require "petitest/autorun"
require "petitest/power_assert"

class PetitestTest < Petitest::Test
  prepend ::Petitest::PowerAssert

  def test_assertion_with_truthy_block_to_pass
    assert do
      true
    end
  end

  def test_assertion_with_truthy_value_to_pass
    assert(true)
  end

  def test_description_to_be_set
    assert do
      self.class.description == "PetitestTest"
    end
  end

  def test_full_description_to_be_set
    assert do
      self.class.full_description == "PetitestTest"
    end
  end

  sub_test "sub test group level 1", a: 1, b: 1 do
    def test_description_be_set
      assert do
        self.class.description == "sub test group level 1"
      end
    end

    def test_full_description_to_be_equal_to_description
      assert do
        self.class.full_description == "PetitestTest sub test group level 1"
      end
    end

    def test_metadata_to_be_set
      assert do
        self.class.metadata == { a: 1, b: 1 }
      end
    end

    sub_test "sub test group level 2", a: 2, c: 2 do
      def test_description_to_be_set
        assert do
          self.class.description == "sub test group level 2"
        end
      end

      def test_full_description_to_be_set
        assert do
          self.class.full_description == "PetitestTest sub test group level 1 sub test group level 2"
        end
      end

      def test_metadata_to_be_merged
        assert do
          self.class.metadata == { a: 2, b: 1, c: 2 }
        end
      end
    end
  end
end
