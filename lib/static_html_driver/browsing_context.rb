module StaticHTMLDriver
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
					when 'class name'
						[:css, ".#{selector}"]
					when 'css selector'
						[:css, selector]
					when 'id'
						[:css, "##{selector}"]
					when 'link text'
						[:xpath, ".//a[text()='#{selector}']"]
					when 'partial link text'
						[:xpath, ".//a[contains(text(), '#{selector}')]"]
					when 'tag name'
						[:css, selector]
					when 'xpath'
						[:xpath, selector]
					else
						raise("Unknown location strategy - #{location_strategy}")
					end
				Element.new(browser.at(*locator))
			end
		end

		def elements(location_strategy, selector)
			locator =
				case location_strategy
				when 'class name'
					[:css, ".#{selector}"]
				when 'css selector'
					[:css, selector]
				when 'id'
					[:css, "##{selector}"]
				when 'link text'
					[:xpath, ".//a[text()='#{selector}']"]
				when 'partial link text'
					[:xpath, ".//a[contains(text(), '#{selector}')]"]
				when 'tag name'
					[:css, selector]
				when 'xpath'
					[:xpath, selector]
				else
					raise("Unknown location strategy - #{location_strategy}")
				end
			browser.search(*locator).map { |node| Element.new(node) }
		end

		def close
			nil
		end
	end
end