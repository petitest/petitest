# Petitest

[![Gem Version](https://badge.fury.io/rb/petitest.svg)](https://rubygems.org/gems/petitest)
[![Documentation](http://img.shields.io/badge/docs-rdoc.info-blue.svg)](http://www.rubydoc.info/github/petitest/petitest)

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
.FFF..

Failures:

  1) PetitestTest#test_false
    assert(false)
    Expected false to be truthy
    # test/petitest_test.rb:9:in `test_false'

  2) PetitestTest#test_nil
    assert(nil)
    Expected nil to be truthy
    # test/petitest_test.rb:13:in `test_nil'

  3) PetitestTest#test_raise
    raise
    RuntimeError

    # test/petitest_test.rb:17:in `test_raise'

Counts:

  6 tests
  3 passes
  3 failures
  0 skips

Times:

  Started:  2017-03-24T03:09:17.776418+09:00
  Finished: 2017-03-24T03:09:17.776527+09:00
  Total:    0.000109s
```

## Plug-ins

- https://github.com/petitest/petitest-assertions
- https://github.com/petitest/petitest-power_assert
- https://github.com/petitest/petitest-tap
