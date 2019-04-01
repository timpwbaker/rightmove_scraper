require 'selenium-webdriver'
require 'webdrivers'
require 'nokogiri'
require 'capybara'

Webdrivers::Chromedriver.version = '2.46'
Webdrivers.logger.level = :DEBUG

options = Selenium::WebDriver::Chrome::Options.new
chrome_bin_path = ENV.fetch('GOOGLE_CHROME_SHIM', nil)
Selenium::WebDriver::Chrome.path = chrome_bin_path if chrome_bin_path
options.binary = chrome_bin_path if chrome_bin_path # only use custom path on heroku
options.add_argument('--headless') # this may be optional

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.javascript_driver = :headless_chrome
Capybara.configure do |config|
  config.default_max_wait_time = 10 # seconds
  config.default_driver = :selenium
end
