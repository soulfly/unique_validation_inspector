# UniqueValidationInspector

A Rake task that helps you find unique validations in models that do not have DB indexes.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'unique_validation_inspector'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install unique_validation_inspector

## Usage

Just run the following command in your Rails app directory:

    $ rake inspect_unique_validations

## Copyright

Copyright © 2017 Igor Khomenko. See LICENSE file for further details.
