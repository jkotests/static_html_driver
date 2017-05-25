module StaticHTMLDriver
	class Browser
		include Container

		attr_reader :native

		def initialize
			@native = nil
		end

		def goto(url)
			html =
				if File.exists?(url)
					File.read(url.sub('file://', ''))
				else
					url
				end
			@native = ::Nokogiri::HTML.parse(html)
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
			'window-983e501e-6efa-47a8-9bbc-8f42020765e1'
		end

		def window_handles
			[window_handle]
		end

		def close
			nil
		end
	end
end