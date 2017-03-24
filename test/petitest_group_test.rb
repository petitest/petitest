require "petitest/autorun"

class PetitestTest < Petitest::TestGroup
  def test_assertion_with_truthy_block_to_pass
    assert do
      true
    end
  end

  def test_assertion_with_truthy_value_to_pass
    assert(true)
  end

  def test_description_to_be_nil
    assert do
      self.class.description.nil?
    end
  end

  def test_full_description_to_be_nil
    assert do
      self.class.full_description.nil?
    end
  end

  sub_test_group "sub test group level 1", a: 1, b: 1 do
    def test_description_be_set
      assert do
        self.class.description == "sub test group level 1"
      end
    end

    def test_full_description_to_be_equal_to_description
      assert do
        self.class.full_description == "sub test group level 1"
      end
    end

    def test_metadata_to_be_set
      assert do
        self.class.metadata == { a: 1, b: 1 }
      end
    end

    sub_test_group "sub test group level 2", a: 2, c: 2 do
      def test_description_to_be_set
        assert do
          self.class.description == "sub test group level 2"
        end
      end

      def test_full_description_to_be_set
        assert do
          self.class.full_description == "sub test group level 1 sub test group level 2"
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
