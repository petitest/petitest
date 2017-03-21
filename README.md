# Petitest

[![Gem Version](https://badge.fury.io/rb/petitest.svg)](https://rubygems.org/gems/petitest)
[![Documentation](http://img.shields.io/badge/docs-rdoc.info-blue.svg)](http://www.rubydoc.info/github/r7kamura/petitest)

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
# test/some_test.rb
require "petitest/autorun"

class Sometest < Petitest::TestGroup
  def test_empty_string
    assert("")
  end

  def test_false
    assert(false)
  end

  def test_nil
    assert(nil)
  end

  def test_raise
    raise
  end

  def test_true
    assert(true)
  end

  def test_zero
    assert(0)
  end
end
```

### 2. Run tests

Run your test file as a Ruby script:

```bash
ruby test/sometest_test.rb
```

```
.FFE..

Failures:

  1) Sometest#test_false
    assert(false)
    false is not truthy
    # test/sometest_test.rb:9:in `test_false'

  2) Sometest#test_nil
    assert(nil)
    nil is not truthy
    # test/sometest_test.rb:13:in `test_nil'

Errors:

  1) Sometest#test_raise
    raise
    RuntimeError:
    # test/sometest_test.rb:17:in `test_raise'

Counts:

  6 tests
  3 passes
  2 failures
  1 errors
  0 skips

Times:

  Started:  2017-03-22T05:40:32.846640+09:00
  Finished: 2017-03-22T05:40:32.846784+09:00
  Total:    0.000144s
```
