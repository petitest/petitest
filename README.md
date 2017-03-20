# Petitest

A minimal solid testing framework for Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "petitest"
```

And then execute:

```bash
bundle
```

Or install it yourself as:

```bash
gem install petitest
```

## Usage

### 1. Write test cases

Define children of `Petitest::TestGroup` with `#test_xxx` methods in `test/**/*_test.rb`:

```ruby
# test/foo_test.rb
require "petitest/autorun"

class FooTest < Petitest::TestGroup
  def foo
    ::Foo.new
  end

  def test_bar
    assert_equal(foo.bar, "bar")
  end

  def test_baz
    assert_equal(foo.baz, "baz")
  end
end
```

### 2. Run tests

Run your test file as a Ruby script:

```bash
ruby test/foo_test.rb
```
