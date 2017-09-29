# README

This is the source code for AnotherVu web application.

## Developer Setup
- Copy `database.yml.example` to `database.yml`. Get production config from another developer if necessary
- Install Postgres
- Create database role in psql: `create role anothervu with CREATEDB LOGIN;`
- `bundle exec rake db:create db:migrate`

## Running in development
`bundle exec rails s`

## Code quality
*TODO* - rspec and rubocop instructions

## Deployment
*TODO* - add info about ENV SECRETS


