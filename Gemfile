source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.0'

gem 'rails', '~> 5.1.0'
gem 'devise', '~> 4.3.0'
gem 'pg'
gem 'puma', '~> 3.7'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'therubyracer', platforms: :ruby
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'sass-rails', '>= 3.2'
gem 'carrierwave', '~> 1.2.1'
gem 'cloudinary', '~> 1.8.1'
gem 'kaminari'
gem 'font-awesome-rails'
gem 'pundit'
gem 'social-share-button'
gem 'rails_admin'
gem 'lightbox2-rails'



group :development, :test do
  gem 'dotenv-rails', '~> 2.2.1'
  gem 'byebug'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'foreman'
  gem 'better_errors'
end

group :test do
  gem 'rspec', '~> 3.5.0'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'vcr'
  gem 'webmock'
  gem 'factory_bot_rails'
  gem 'selenium-webdriver'
  gem 'capybara'
  gem 'capybara-selenium'
  gem 'database_cleaner'
  gem 'launchy'
end

group :production do
  gem 'rails_12factor'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
