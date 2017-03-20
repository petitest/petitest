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

Define a child class of `Petitest::TestGroup` with `#test_xxx` methods.

```ruby
# test/foo_test.rb
require "petitest/autorun"

class FooTest < Petitest::TestGroup
  def foo
    ::Foo.new
  end

  def test_bar
    assert_equal("bar", foo.bar)
  end

  def test_baz
    assert_equal("baz", foo.baz)
  end
end
```

### 2. Run tests

Run your test file as a Ruby script:

```bash
ruby test/foo_test.rb
```
