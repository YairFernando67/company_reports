# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.2"

gem "devise"
gem "jbuilder", "~> 2.7"
gem "pg", ">= 0.18", "< 2.0"
gem "pry-rails"
gem "puma", "~> 4.1"
gem "rails", "~> 6.0.3", ">= 6.0.3.4"
gem "sass-rails", ">= 6"
gem "slim-rails", "~> 3.2"
gem "turbolinks", "~> 5"
gem "webpacker", "~> 4.0"
gem "wicked_pdf"
# gem 'wkhtmltopdf-binary'
gem "wkhtmltopdf-binary"
# gem 'wkhtmltopdf-binary-edge', '~> 0.12.6.0'
gem "bootsnap", ">= 1.4.2", require: false
# gem 'material_design_lite-sass'
gem "material_icons"
gem "materialize-sass"

group :development, :test do
  gem "awesome_print"
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "pry"
  gem "pry-byebug"
  gem "rubocop", "0.79.0"
  gem "rubocop-md"
  gem "rubocop-performance", require: false
  gem "rubocop-rspec"
end

group :development do
  gem "listen", "~> 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "webdrivers"
end

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
