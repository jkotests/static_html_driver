module Selenium
	module WebDriver
		module StaticHTML
			module DriverExt
				def for(browser, opts = {})
					return super unless browser == :static_html

					bridge = StaticHTML::Bridge.new(opts)
					new(bridge)
				end

				Selenium::WebDriver::Driver.singleton_class.prepend(self)
			end
		end
	end
end