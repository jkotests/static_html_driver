module Selenium
	module WebDriver
		module StaticHTML
			class Http < Remote::Http::Default
				def new_http_client
					RubyRemoteEnd::RemoteEnd.new('StaticHTML', server_url.path)
				end
			end
		end
	end
end