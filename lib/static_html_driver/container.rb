module StaticHTMLDriver
	module Container
		def element(location_strategy, selector)
			if location_strategy == :ole_object
				e = native.css('*').find { |node| node.pointer_id == selector }
				Element.new(e)
			else
				locator = normalize_location_strategy(location_strategy, selector)
				Element.new(native.at(*locator))
			end
		end

		def elements(location_strategy, selector)
			locator = normalize_location_strategy(location_strategy, selector)
			native.search(*locator).map { |node| Element.new(node) }
		end

		private

		def normalize_location_strategy(location_strategy, selector)
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
					[:xpath, XPathBuilder.new(selector).normalize]
				else
					raise("Unknown location strategy - #{location_strategy}")
				end
			locator
		end
	end
end