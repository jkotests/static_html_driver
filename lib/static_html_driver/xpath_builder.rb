module StaticHTMLDriver
	class XPathBuilder
		def initialize(org_xpath)
			@xpath = org_xpath
		end

		def normalize
			@xpath = remove_regexp_selector_predicates(@xpath)
			@xpath
		end

		def remove_regexp_selector_predicates(xpath)
			# Warning: This does not verify whether the leading bracket is required.
			re =
				/
					^                              # begins with
					\((.+)\)
					(\[                            # predicate added for regexp selector
						contains\(
							(?:normalize-space\()?     # :href also normalizes-space
								@[\w+-]+                 # attribute name
							\)?
							,[ ]                       # comma and space separator
							'.+'                       # attribute value
						\)
					\])
					$                              # ends with
				/x
			result = xpath
			loop do
				data = result.match(re)
				return result unless data
				result = "#{data[1]}#{data[2]}"
			end
		end
	end
end