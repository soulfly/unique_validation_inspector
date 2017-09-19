# UniqueValidationInspector

![build passing](https://travis-ci.org/soulfly/unique_validation_inspector.svg?branch=master)
[![Gem Version](https://badge.fury.io/rb/unique_validation_inspector.svg)](https://badge.fury.io/rb/unique_validation_inspector)

A Rake task that helps you find unique validations in models that do not have proper DB indexes.

If uniqueness validation is enabled, Rails will look for existing records before performing **Model.create**, **Model.save**, **Model.update** ... operations. If a record was found the validation fails and the transaction will be rolled back, if not the record will be saved.

For example, you have **User** model and uniqueness validation for **facebook_id** field. The following SQL query will be performed on validation:

```sql
 SELECT  1 AS one FROM `users` WHERE (`users`.`facebook_id ` = 1523123128921623) LIMIT 1
```
If you do not have DB index for **facebook_id** field then your **Model.create**, **Model.save**, **Model.update** ... operations will be slower and slower with user base grow. 

So this gem is here to notify you about it.

Read [Rails: make sure you have proper DB indexes for your model’s unique validations](https://medium.com/@igorkhomenko/rails-make-sure-you-have-proper-db-indexes-for-your-models-unique-validations-ffd0364df26f) article to understand what kind of performance issues you may have without proper indexes.

Also read [How I Reduced my DB Server Load by 80%](https://schneems.com/2017/07/18/how-i-reduced-my-db-server-load-by-80/) article.

## Supported versions
* Ruby 1.8.7, 1.9.2, 1.9.3, 2.0, 2.1, 2.2, 2.3, 2.4, 2.5 (trunk)

* Rails 3.0.x, 3.1.x, 3.2.x, 4.0.x, 4.1.x, 5.0.x

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
[:blob_id]. Index exists: true
```
All things with **Index exists: false** are problematic and you should fix it by adding proper DB indexes.

Consider use one of the following solutions to resolve above issues:
* Add proper DB index.
* Move unique validation to DB level.
More info in the article https://medium.com/@igorkhomenko/rails-make-sure-you-have-proper-db-indexes-for-your-models-unique-validations-ffd0364df26f

## Copyright

Copyright © 2017 Igor Khomenko. See LICENSE file for further details.
