# Capybara とSelenium WebDriverの設定
require 'capybara/rails'
require 'capybara/rspec'
require 'selenium-webdriver'
require 'capybara-screenshot/rspec'

# Chrome Headless設定
Capybara.register_driver :selenium_chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--disable-gpu')
  options.add_argument('--remote-debugging-port=9222')
  options.add_argument('--window-size=1400,1400')
  options.add_argument('--disable-features=VizDisplayCompositor')

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

# Chrome設定（デバッグ用）
Capybara.register_driver :selenium_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--window-size=1400,1400')

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

# 環境に応じてドライバーを切り替え
if ENV['HEADLESS'] || ENV['CI']
  Capybara.javascript_driver = :selenium_chrome_headless
else
  Capybara.javascript_driver = :selenium_chrome
end

# Capybara設定
Capybara.default_driver = :rack_test
Capybara.default_max_wait_time = 5
Capybara.server_host = '0.0.0.0'
Capybara.server_port = 3001
Capybara.app_host = 'http://127.0.0.1:3001'

# スクリーンショット設定
Capybara::Screenshot.autosave_on_failure = true
Capybara::Screenshot.prune_strategy = :keep_last_run