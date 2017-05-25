module StaticHTMLDriver
	class Element
		include Container

		attr_reader :native

		def initialize(native)
			@native = native
		end

		def exists?
			!native.nil?
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