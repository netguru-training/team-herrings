# Herrings App
![Travis status](https://travis-ci.org/netguru-training/team-herrings.svg?branch=master)
[![Join the chat at https://gitter.im/netguru-training/team-herrings](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/netguru-training/team-herrings?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

## :hash: Description

## :closed_lock_with_key: Technology

| Name |  Version |
| :--: | :---: |
| [Ruby](https://www.ruby-lang.org) | 2.2.3 |
| [Ruby on Rails](http://www.rubyonrails.org/) | 4.2.5 |
| [PostgreSQL](http://www.postgresql.org/) | 9.4.4 |
| [Bootstrap](https://github.com/twbs/bootstrap-sass) | 3.3.6 |
| [Rspec](https://github.com/rspec/rspec-rails) | 3.4.1 |

## :hammer: Setup

### :information_source: Gems

Run `bundle install` before you continue.

### :elephant: Setup PostgreSQL database

You can follow the instructions on [PostgreSQL site](http://www.postgresql.org/download/) or use Homebrew.

Create `config/database.yml`.

```
cp config/database.yml.sample config/database.yml
```

Create databases (development and test):

```bash
rake db:create
rake db:schema:load
rake db:seed
```

### :pencil: Default configuration

Use `config/secrets.yml`

Ask developer about credentials.

### :up: Start application

Before you start app be sure that PostgreSQL is already running. Then start Rails server on default port.

```bash
rails server
```

### :vertical_traffic_light: Testing

We use `Rspec` for testing. To execute all tests please use following command:

```
rspec
```

Please remember about checking your changes in the code this way.
