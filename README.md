# UniqueValidationInspector

A Rake task that helps you find unique validations in models that do not have proper DB indexes.

Read [How I Reduced my DB Server Load by 80%] (https://schneems.com/2017/07/18/how-i-reduced-my-db-server-load-by-80/) article to understand what kind of performance issues you may have without proper indexes.

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

## Output

```bash
You have the following unique validations:

Model 'Application':
[:title] (scope 'account_id'). Index exists: false

Model 'User':
[:email] (scope 'application_id'). Index exists: true
[:login] (scope 'application_id'). Index exists: false
[:facebook_id] (scope 'application_id'). Index exists: true
[:twitter_id] (scope 'application_id'). Index exists: false
[:external_user_id] (scope 'application_id'). Index exists: false
[:blob_id] (scope ''). Index exists: true
```
All things with **Index exists: false** are problematic and you should fix it by adding proper DB indexes. 

## Copyright

Copyright © 2017 Igor Khomenko. See LICENSE file for further details.
