module StaticHTMLDriver
	module SpecSupport
		module Navigation
			class << self
				def url_for(page)
					File.join(html_dir, page)
				end

				def html_dir
					File.join(__dir__, 'html')
				end
			end
		end
	end
end