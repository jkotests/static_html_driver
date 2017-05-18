module StaticHTMLDriver
	class BrowsingContext
		attr_reader :browser

		def initialize
			@browser = nil
		end

		def goto(url)
			html =
				if File.exists?(url)
					File.read(url.sub('file://', ''))
				else
					url
				end
			@browser = ::Nokogiri::HTML.parse(html)
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

		def execute_script(session, script, args)
			# TODO: This is currently hardcoded to handle the get_attribute_value atom
			element_id = args.first['element-6066-11e4-a52e-4f735466cecf']
			e_ole = session.known_elements[element_id]
			e = element(:ole_object, e_ole)
			attr = args[1]
			e.attribute_value(attr)
		end

		def window_handle
			'1'
		end

		def window_handles
			['1']
		end

		def close
			nil
		end
	end
end