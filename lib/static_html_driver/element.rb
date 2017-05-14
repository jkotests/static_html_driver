module StaticHTMLDriver
	class Element
		attr_reader :native

		def initialize(native)
			@native = native
		end

		def element(location_strategy, selector)
			if location_strategy == :ole_object
				descendent = native.css('*').find { |node| node.pointer_id == selector }
				Element.new(descendent)
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
				Element.new(native.at(*locator))
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
			native.search(*locator).map { |node| Element.new(node) }
		end

		def exists?
			!!native
		end

		def ole_object
			native.pointer_id
		end

		def attribute_value(attr)
			native[attr]
		end

		def tag_name
			native.name
		end

		def text
			native.text.strip
		end

		def enabled?
			!attribute_value('disabled')
		end
	end
end