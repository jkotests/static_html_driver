require 'spec_helper'

module StaticHTMLDriver
	describe 'Session Commands' do
		before(:all) do
			driver.navigate.to SpecSupport::Navigation.url_for('elements.html')
		end

		describe 'Get Window Handle' do
			it 'gets the window handle' do
				expect(driver.window_handle).to eq('1')
			end
		end

		describe 'Get Window Handles' do
			it 'gets the window handles' do
				expect(driver.window_handles).to eq(['1'])
			end
		end
	end
end