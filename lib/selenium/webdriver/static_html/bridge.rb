module Selenium
	module WebDriver
		module StaticHTML
			class Bridge < Remote::W3CBridge
				attr_accessor :http

				def initialize(opts = {})
					opts[:http_client] ||= ::Selenium::WebDriver::StaticHTML::Http.new

					super
				end
			end
		end
	end
end