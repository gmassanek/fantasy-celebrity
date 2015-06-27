require "capybara/poltergeist"
require "cucumber/rails"
require Rails.root.join("lib/builders")

ActionController::Base.allow_rescue = false

DatabaseCleaner.strategy = :transaction
Cucumber::Rails::Database.javascript_strategy = :truncation

Capybara.app = Builders::FULL_STACK

headless = (ENV["HEADLESS"] == "true")
if headless
  Capybara.register_driver(:poltergeist) do |app|
    Capybara::Poltergeist::Driver.new(app, { debug: false, extensions: ["vendor/poltergeist/bind.js"] })
  end
else
  Capybara.register_driver(:browser) do |app|
    Capybara::Selenium::Driver.new(app, { browser: :chrome })
  end
end
Capybara.default_driver = Capybara.javascript_driver = (headless ? :poltergeist : :browser)
