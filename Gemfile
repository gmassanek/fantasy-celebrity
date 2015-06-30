source "https://rubygems.org"

gem "active_model_serializers", "~> 0.9.3"
gem "jbuilder", "~> 2.0"
gem "pg"
gem "puma", "~> 2.11.3"
gem "rack-cors"
gem "rails", "4.2.2"

group :development do
  gem "capistrano-rails"
  gem "capistrano3-puma"
  gem "foreman"
end

group :development, :test do
  gem "byebug"
  gem "rspec-rails", "~> 3.0"
  gem "spring"
  gem "web-console", "~> 2.0"
end

group :doc do
  gem "sdoc", "~> 0.4.0"
end

group :test do
  gem "bundler-audit"
  gem "cucumber-rails", { require: false }
  gem "database_cleaner"
  gem "launchy"
  gem "poltergeist"
  gem "rubocop", { require: false }
  gem "selenium-webdriver"
end
