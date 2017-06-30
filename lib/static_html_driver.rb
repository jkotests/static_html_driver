require 'nokogiri'
require_relative '../../ruby_remote_end/lib/ruby_remote_end'
require 'selenium-webdriver'

require_relative 'selenium/webdriver/static_html/driver_ext'
require_relative 'selenium/webdriver/static_html/bridge'
require_relative 'selenium/webdriver/static_html/http'

require_relative 'static_html_driver/container'
require_relative 'static_html_driver/browser'
require_relative 'static_html_driver/element'
require_relative 'static_html_driver/session'
require_relative 'static_html_driver/xpath_builder'