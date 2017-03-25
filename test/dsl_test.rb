require "petitest/autorun"
require "petitest/power_assert"

class PetitestTest < Petitest::Test
  extend ::Petitest::DSL
  prepend ::Petitest::PowerAssert

  test "skip test"

  desc "test desc DSL"
  def test_desc
    assert do
      runner.description == "test desc DSL"
    end
  end

  sub_test "sub test group level 1", a: 1, b: 1 do
    test "test group description" do
      assert do
        runner.test_group.description == "sub test group level 1"
      end
    end

    test "test group full description" do
      assert do
        runner.test_group.full_description == "PetitestTest sub test group level 1"
      end
    end

    test "test group metadata" do
      assert do
        runner.test_group.metadata == { a: 1, b: 1 }
      end
    end

    test "test description" do
      assert do
        runner.description == "test description"
      end
    end

    test "test full description" do
      assert do
        runner.full_description == "PetitestTest sub test group level 1 test full description"
      end
    end

    sub_test "sub test group level 2", a: 2, c: 2 do
      test "test group description" do
        assert do
          runner.test_group.description == "sub test group level 2"
        end
      end

      test "test group metadata inheritance" do
        assert do
          runner.test_group.metadata == { a: 2, b: 1, c: 2 }
        end
      end
    end
  end
end
