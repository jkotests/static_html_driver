require 'spec_helper'

module StaticHTMLDriver
	describe 'Element Commands' do
		before(:all) do
			driver.navigate.to SpecSupport::Navigation.url_for('elements.html')
		end

		describe 'Get Element Attribute' do
			it 'gets the attribute value' do
				expect(driver.find_element(id: 'header').attribute('class')).to eq('headerClass')
			end

			it 'should return nil for non-existent attributes' do
				expect(driver.find_element(id: 'main').attribute('nonexistent')).to be_nil
			end
		end

		describe 'Get Element Tag Name' do
			it 'gets the tag name' do
				expect(driver.find_element(id: 'header').tag_name).to eq('div')
			end
		end

		describe 'Get Element Text' do
			it 'gets the text' do
				expect(driver.find_element(id: 'main').text).to eq('Main content')
			end
		end

		describe 'Is Element Enabled' do
			it 'identifies enabled elements' do
				expect(driver.find_element(id: 'isEnabled')).to be_enabled
				expect(driver.find_element(id: 'isDisabled')).not_to be_enabled
			end
		end
	end
end