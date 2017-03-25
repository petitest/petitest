# Petitest

[![Gem Version](https://badge.fury.io/rb/petitest.svg)](https://rubygems.org/gems/petitest)
[![Documentation](http://img.shields.io/badge/docs-rdoc.info-blue.svg)](http://www.rubydoc.info/github/petitest/petitest)

A minimal solid testing framework for Ruby.

![demo](/images/demo.png)

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

### 1. Write tests

Define a child class of `Petitest::Test` with `#test_xxx` methods.

```ruby
require "petitest/autorun"

class ExampleTest < Petitest::Test
  def test_addition
    assert { 1 + 1 == 100 }
  end
end
```

### 2. Run tests

Run your test file as a Ruby script:

```bash
ruby test/example_test.rb
```

```
PetitestTest
  #test_one_plus_one_to_be_two


Counts:

  1 tests
  1 passes
  0 failures
  0 skips

Times:

  Started:  2017-03-25T15:29:21.243918+09:00
  Finished: 2017-03-25T15:29:21.244149+09:00
  Total:    0.000231s
```

## Subscriber events

- `#before_running_test_plan(test_plan)`
- `#before_running_test_group(test_group)`
- `#before_running_test(test)`
- `#after_running_test(test)`
- `#after_running_test_group(test_group)`
- `#after_running_test_plan(test_plan)`

## Official plugins

- https://github.com/petitest/petitest-assertions
- https://github.com/petitest/petitest-power_assert
- https://github.com/petitest/petitest-tap
