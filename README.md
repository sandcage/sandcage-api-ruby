![SandCage](https://d18m5nnl28b2pp.cloudfront.net/p/a/img/header.png)

[![Scrutinizer Code Quality](https://scrutinizer-ci.com/g/sandcage/sandcage-api-ruby/badges/quality-score.png?b=master)](https://scrutinizer-ci.com/g/sandcage/sandcage-api-ruby/?branch=master)
[![Gem Version](https://badge.fury.io/rb/sandcage.svg)](https://rubygems.org/gems/sandcage)

sandcage-api-ruby is a Ruby library for interfacing with SandCage's API. The API documentation can be found at https://www.sandcage.com/docs/0.2/

### Table of Contents
* [Installation](https://github.com/sandcage/sandcage-api-ruby/blob/master/README.md#installation)
* [Examples](https://github.com/sandcage/sandcage-api-ruby/tree/master/examples)
* [Contributing](https://github.com/sandcage/sandcage-api-ruby/blob/master/README.md#contributing)
* [Contact Us](https://www.sandcage.com/contact)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sandcage'
```

And then execute:

	$ bundle

Or install it yourself as:

    $ gem install sandcage

## Usage

Simply:
```ruby
require 'sandcage'
sc = Sandcage::Client.new('[YOUR_SANDCAGE_API_KEY]')
# Then for examples to use list_files service
response = sc.list_files_service
```


To not include YOUR_SANDCAGE_API_KEY into your code you can for example save it as a file named SANDCAGE_API_KEY into your home directory

```
cd ~
echo YOUR_SANDCAGE_API_KEY > SANDCAGE_API_KEY
```
and then use the following code to initialize Sandcage client

```ruby
require "sandcage"
api_key_dir = File.expand_path("~")
api_key_file = File.join(api_key_dir, "SANDCAGE_API_KEY")
api_key = IO.readlines(api_key_file)[0]
	
sc = Sandcage::Client.new(api_key)
```

## Contributing

We are open to suggestions and code revisions, however there are some rules and limitations that you might want to consider first.

* Code that you contribute will automatically be licensed under the [Apache License Version 2.0](https://github.com/sandcage/sandcage-api-ruby/blob/master/LICENSE).
* Third party code will be reviewed, tested and possibly modified before being released.

These basic rules help ensure that this code remains Open Source and compatible with Apache 2.0 license. All contributions will be added to the changelog and appear in every release.
