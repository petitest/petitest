# Petitest

[![Gem Version](https://badge.fury.io/rb/petitest.svg)](https://rubygems.org/gems/petitest)
[![Documentation](http://img.shields.io/badge/docs-rdoc.info-blue.svg)](http://www.rubydoc.info/github/petitest/petitest)

A minimal solid testing framework for Ruby.

![demo](/images/demo.png)

## Usage

### Installation

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

### Create your test file

Define a child class of `Petitest::Test` with `#test_xxx` methods.

```ruby
require "petitest/autorun"

class ExampleTest < Petitest::Test
  def test_addition
    assert { 1 + 1 == 100 }
  end
end
```

### Run it

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

If any test failed, exit code 1 is returned, othewise 0.

```bash
echo $?
```

```
0
```

### Assertions

Only `#assert` is provided for simplicity.

```ruby
assert { foo }
```

### Configuration

Default configuration example:

```ruby
Petitest.configuration.color = true

Petitest.configuration.backtrace_filters = [
  -> (line) { line.start_with?("/path/to/petitest/lib") },
]

Petitest.configuration.color_scheme = {
  detail: :cyan,
  error: :red,
  pass: :green,
  skip: :yellow,
}

Petitest.configuration.output = ::STDOUT
Petitest.configuration.output.sync = true

Petitest.configuration.subscribers = [
  ::Petitest::Subscribers::JsonReportSubscriber.new,
]
```

### Color types

These color types are available on color scheme configuration:

- `:black`
- `:blue`
- `:bold`
- `:cyan`
- `:green`
- `:magenta`
- `:red`
- `:white`
- `:yellow`

### Subscribers

These subscribers are provided by default:

- `Petitest::Subscribers::DocumentReportSubscriber` (default)
- `Petitest::Subscribers::JsonReportSubscriber`
- `Petitest::Subscribers::ProgressReportSubscriber`

### Official Plugins

Here are some official plugins for Petitest:

- https://github.com/petitest/petitest-assertions
- https://github.com/petitest/petitest-power_assert
- https://github.com/petitest/petitest-tap

## For developers

### Tree

```
TestPlan
|---Test 1
|---Test 2
|---Test 3
|---TestGroup 1
|   |---Test 1-1
|   |---Test 1-2
|   |---Test 1-3
|   `---TestGroup1-1
|       |---Test 1-1-1
|       |---Test 1-1-2
|       `---Test 1-1-3
|---TestGroup2
|   |---Test 2-1
|   |---Test 2-2
|   `---Test 2-3
`---TestGroup3
    |---Test 3-1
    |---Test 3-2
    |---Test 3-3
    `---TestGroup3-1
        |---Test 3-1-1
        |---Test 3-1-2
        `---Test 3-1-3
```

### Order

1. Test 1
1. Test 2
1. Test 3
1. Test 1-1
1. Test 1-2
1. Test 1-3
1. Test 1-1-1
1. Test 1-1-2
1. Test 1-1-3
1. Test 2-1
1. Test 2-2
1. Test 2-3
1. Test 3-1
1. Test 3-2
1. Test 3-3
1. Test 3-1-1
1. Test 3-1-2
1. Test 3-1-3

### Events

- `#before_running_test_plan(test_plan)`
- `#before_running_test_group(test_group)`
- `#before_running_test(test)`
- `#after_running_test(test)`
- `#after_running_test_group(test_group)`
- `#after_running_test_plan(test_plan)`
