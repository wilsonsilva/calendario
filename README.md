# Calendario

[![Gem Version](https://badge.fury.io/rb/calendario.svg)](https://badge.fury.io/rb/calendario)
[![Build Status](https://travis-ci.org/wilsonsilva/calendario.svg?branch=master)](https://travis-ci.org/wilsonsilva/calendario)
[![Maintainability](https://api.codeclimate.com/v1/badges/98a431421f7754ffe8fc/maintainability)](https://codeclimate.com/github/wilsonsilva/calendario/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/98a431421f7754ffe8fc/test_coverage)](https://codeclimate.com/github/wilsonsilva/calendario/test_coverage)
[![Security](https://hakiri.io/github/wilsonsilva/calendario/master.svg)](https://hakiri.io/github/wilsonsilva/calendario/master)
[![Inline docs](http://inch-ci.org/github/wilsonsilva/calendario.svg?branch=master)](http://inch-ci.org/github/wilsonsilva/calendario)

A cal-like calendar.

```shell script
                            2020
      January               February               March
Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa
          1  2  3  4                     1   1  2  3  4  5  6  7
 5  6  7  8  9 10 11   2  3  4  5  6  7  8   8  9 10 11 12 13 14
12 13 14 15 16 17 18   9 10 11 12 13 14 15  15 16 17 18 19 20 21
19 20 21 22 23 24 25  16 17 18 19 20 21 22  22 23 24 25 26 27 28
26 27 28 29 30 31     23 24 25 26 27 28 29  29 30 31


       April                  May                   June
Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa
          1  2  3  4                  1  2      1  2  3  4  5  6
 5  6  7  8  9 10 11   3  4  5  6  7  8  9   7  8  9 10 11 12 13
12 13 14 15 16 17 18  10 11 12 13 14 15 16  14 15 16 17 18 19 20
19 20 21 22 23 24 25  17 18 19 20 21 22 23  21 22 23 24 25 26 27
26 27 28 29 30        24 25 26 27 28 29 30  28 29 30
                      31

        July                 August              September
Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa
          1  2  3  4                     1         1  2  3  4  5
 5  6  7  8  9 10 11   2  3  4  5  6  7  8   6  7  8  9 10 11 12
12 13 14 15 16 17 18   9 10 11 12 13 14 15  13 14 15 16 17 18 19
19 20 21 22 23 24 25  16 17 18 19 20 21 22  20 21 22 23 24 25 26
26 27 28 29 30 31     23 24 25 26 27 28 29  27 28 29 30
                      30 31

      October               November              December
Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa
             1  2  3   1  2  3  4  5  6  7         1  2  3  4  5
 4  5  6  7  8  9 10   8  9 10 11 12 13 14   6  7  8  9 10 11 12
11 12 13 14 15 16 17  15 16 17 18 19 20 21  13 14 15 16 17 18 19
18 19 20 21 22 23 24  22 23 24 25 26 27 28  20 21 22 23 24 25 26
25 26 27 28 29 30 31  29 30                 27 28 29 30 31
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'calendario'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install calendario

## Usage

Rendering the current year:
```ruby
calendar = Calendario::Calendar.new
puts calendar.render_current_year
```

You can also customize what to display on each day. For example, this code wil display the letters WE on weekends:
```ruby
calendar = Calendario::Calendar.new
rendered_calendar = calendar.render_current_year do |date|
  if date.wday == 5 ||  if date.wday == 6
    'WE'
  else
    date.day.to_s.rjust(2)
  end
end

puts rendered_calendar
```

## Development

After checking out the repo, run `bin/setup` to install dependencies, configure git hooks and create support files.

You can also run `bin/console` for an interactive prompt that will allow you to experiment.

The health and maintainability of the codebase is ensured through a set of
Rake tasks to test, lint and audit the gem for security vulnerabilities and documentation:

```
rake bundle:audit          # Checks for vulnerable versions of gems
rake qa                    # Test, lint and perform security and documentation audits
rake rubocop               # Lint the codebase with RuboCop
rake rubocop:auto_correct  # Auto-correct RuboCop offenses
rake spec                  # Run RSpec code examples
rake verify_measurements   # Verify that yardstick coverage is at least 100%
rake yard                  # Generate YARD Documentation
rake yard:junk             # Check the junk in your YARD Documentation
rake yardstick_measure     # Measure docs in lib/**/*.rb with yardstick
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wilsonsilva/calendario. This project is
intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the
[code of conduct](https://github.com/wilsonsilva/calendario/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Calendario project's codebases, issue trackers, chat rooms and mailing lists is expected
to follow the [code of conduct](https://github.com/wilsonsilva/calendario/blob/master/CODE_OF_CONDUCT.md).
