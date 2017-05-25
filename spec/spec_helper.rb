$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rspec'

require 'static_html_driver'
require 'watir'
require 'spec_support/navigation'
require 'spec_support/helpers'

include StaticHTMLDriver

$browser = Watir::Browser.new(:static_html)

RSpec.configure do |c|
	c.include(SpecSupport::Helpers)

	c.after(:suite) do
		$browser.close
	end
end