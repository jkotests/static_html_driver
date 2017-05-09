module RubyRemoteEnd
	module StaticHTML
		class BrowsingContext
			attr_reader :browser

			def initialize
				@browser = nil
			end

			def goto(url)
				file = File.read(url.sub('file://', ''))
				@browser = ::Nokogiri::HTML.parse(file)
			end

			def element(location_strategy, selector)
				if location_strategy == :ole_object
					native = browser.css('*').find { |node| node.pointer_id == selector }
					Element.new(native)
				else
					locator =
						case location_strategy
						when 'id'
							[:css, "##{selector}"]
						when 'class name'
							[:xpath, ".//*[@class='#{selector}']"]
						else
							raise("Unknown location strategy - #{location_strategy}")
						end
					Element.new(browser.at(*locator))
				end
			end

			def close
				nil
			end
		end
	end
end