# TypoSafe

Protect your Ruby code from typos! You've heard of Type Safe languages, well now Ruby can be Typo Safe! Typo Safe code will revolutionise programming.

## Installation

Add this line to your application's Gemfile:

    gem 'typo_safe'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install typo_safe

## Usage

I'm pretty sure you don't ever want to use this gem, not even in development.

### Typo Safe a single class written by a fat-fingered developer:

```ruby
require 'typo_safe'

class SomeClass
	include TypoSafe

	def print_hell0
		puts "hello from the print_hello method!"
	end

	def print_goodbye
		puts "goodbye from the print_goodbye method!"
	end
end

SomeClass.new.print_hello
SomeClass.new.pring_goodbye
```

## Why?!

A discussion in Campfire:

![Alt text](http://i.imgur.com/oHTdT.png)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Write, then test your changes (`rake test`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request

## TODO

* Make the gem respect public/private methods (at the moment you can call a private method by using a typo)
* Benchmark Levenshtein calculations and possibly cache
* At the moment when there is a conflict (two methods have the same Levenshtein distance) the first is picked, maybe favour locally defined methods over inherited methods
* Make including TypoSafe on Object work (for global protection!)
