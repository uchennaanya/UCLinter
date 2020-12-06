# UCLinter

This project is about building a custom Linter that makes sure that a source code conforms to a particular standard.

# Ruby Capstone Project - Ruby Linter

[![View Code](https://img.shields.io/badge/View%20-Code-green)](https://github.com/uchennaanya/UCLinter)
[![Github Issues](https://img.shields.io/badge/GitHub-Issues-orange)](https://github.com/uchennaanya/UCLinter/issues)
[![GitHub Pull Requests](https://img.shields.io/badge/GitHub-Pull%20Requests-blue)](https://github.com/uchennaanya/UCLinter/pulls)

# About

# The Build

The custom linter currently checks for the following errors in a ruby file.

- check for wrong indentations
- check for trailing spaces error
- check for missing/unexpected tags example '( )', '[ ]', and '{ }'
- check for missing/unexpected end of file
- check for empty line errors

> Below are examples of good and bad test for the above cases. '|' symbol indicate cursor position where needed.

## Indentation Error Check

```ruby
# Good Code

class Ticket
  def initialize(venue, date)
    @venue = venue
    @date = date
  end
end

# Bad Code

class Ticket
  def initialize(venue, date)
    @venue = venue
      @date = date
  end
end
```

## Trailing spaces

> note where the cursor(|) is on the bad code

```ruby
# Good Code

class Ticket
  def initialize(venue, date)
    @venue = venue
    @date = date
  end
end

# Bad Code

class Ticket
  def initialize(venue, date)  |
    @venue = venue
    @date = date
  end
end
```

## Missing/Unexpected Tag

```ruby
# Good Code

class Ticket
  def initialize(venue, date)
    @venue = venue
    @date = date
  end
end

# Bad Code

class Ticket
  def initialize(venue, date
    @venue = venue
    @date = [[date]
  end
end
```

## Missing/unexpected end

```ruby
# Good Code

class Ticket
  def initialize(venue, date)
    @venue = venue
    @date = date
  end
end

# Bad Code

class Ticket
  def initialize(venue, date)
    @venue = venue
    @date = date
  end
  end
end
```

## Empty line error

```ruby
# Good Code

class Ticket
  def initialize(venue, date)
    @venue = venue
    @date = date
  end
end

# Bad Code

class Ticket
  def initialize(venue, date)

    @venue = venue
    @date = date
  end
end
```

## Built With

- [Ruby](https://www.ruby-lang.org/en/)
- RSpec for [Ruby](https://www.ruby-lang.org/en/) Testing

# Getting Started

To get a local copy of the repository please run the following commands on your terminal:

```
$ cd <folder>
```

```
$ git clone https://github.com/uchennaanya/UCLinter.git
```

**To check for errors on a file:**

```bash
$ bin/main bug.rb
```

## Testing

To test the code, run `rspec` from root of the folder using terminal.
Note: `bug.rb` has been excluded from rubocop checks to allow RSpec testing without interfering with Gitflow actions

> Rspec is used for the test, to install the gem file, run

```bash
$ bundle install
```

> But before that, make sure you have **bundler** installed on your system, else run

```bash
$ gem install bundler
```

> or you simply install the the following directly using

```bash
$ gem install rspec
```

```bash
$ gem install colorize
```

# Author

👤 **Uchenna Anya**

- Github: [uchennnaanya](https://github.com/uchennaanya/)
- Twitter: [@martinsanya19](https://twitter.com/martinsanya19)
- Linkedin: [uchenna-anya](https://www.linkedin.com/in/uchenna-anya/)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- Project inspired by [Microverse](https://www.microverse.org)
