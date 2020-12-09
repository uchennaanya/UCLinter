![](https://img.shields.io/badge/Microverse-blueviolet)

# Ruby Capstone Project: Linters for Ruby code

[![View Code](https://img.shields.io/badge/View%40-Code-yellow)](https://github.com/uchennaanya/UCLinter)
[![Github Issues](https://img.shields.io/badge/GitHub-Issues-orange)](https://github.com/uchennaanya/UCLinter/issues)
[![GitHub Pull Requests](https://img.shields.io/badge/GitHub-Pull%20Requests-blue)](https://github.com/uchennaanya/UCLinter/pulls)

# About

This project is about building a custom Linter that makes sure that a source code conforms to a particular standard.

# The Build

The custom linter currently checks for the following errors in a ruby file.


- check for trailing white spaces errors
- check for missing/unexpected tags example '( )', '[ ]', and '{ }'
- check for missing/unexpected end of file
- check for empty line errors

> Below are examples of good and bad test for the above cases. '|' symbol indicate cursor position where needed.

## Trailing white spaces

> note where the cursor(|) is on the bad code

```ruby
# Valid Code

class Car
  def initialize(name, model)
    @name = name
    @model = model
  end
end

# invalid Code

class Car
  def initialize(name, model)  |
    @name = name
    @model = model
  end
end
```

## Missing/Unexpected Tag

```ruby
# Valid Code

class Car
  def initialize(name, model)
    @name = name
    @model = model
  end
end

# invalid Code

class Car
  def initialize(name, model
    @name = name
    @model = [model
  end
end
```

## Missing/unexpected end

```ruby
# Good Code

class Car
  def initialize(name, model)
    @name = name
    @model = model
  end
end

# Bad Code

class Car
  def initialize(namee, model)
    @venue = name
    @date = model
  end
  end
end
```

## Empty line error

```ruby
# Good Code

class Car
  def initialize(name, model)
    @name = name
    @model = model
  end
end

# Bad Code

class Car
  def initialize(name, model)

    @name = name
    @model = model
  end
end
```

## Built With

- [Ruby](https://www.ruby-lang.org/en/)

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
