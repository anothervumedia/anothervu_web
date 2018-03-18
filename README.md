# README

This is the source code for AnotherVu web application.

## Developer Setup
- Copy `database.yml.example` to `database.yml`. Get production config from another developer if necessary
- Create 2 files. Copy `.env.example` to `.env` and `.env.test`. Get the .env values from another developer and keep them out of this source control
- Install Postgres
- Create database role in psql: `CREATE ROLE anothervu with CREATEDB LOGIN;`
- `bundle exec rake db:create db:migrate`
- `bundle exec foreman start`
- visit `localhost:5000`

## Development process

- Get latest code on the development branch `git checkout master` and `git pull`
- Branch off of development branch `git checkout -b [the_name_of_your_feature]`
- Code feature with test coverage
- Run rubocop for consistent style (*TODO* add command)
- Ensure all tests pass `rspec spec`
- Submit a pull request on Github


## Deployment
*TODO* - add info about ENV SECRETS


