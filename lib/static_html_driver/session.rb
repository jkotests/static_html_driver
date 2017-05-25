module StaticHTMLDriver
	class Session < RubyRemoteEnd::Session
		def self.initialize_browser
			Browser.new
		end
	end
end