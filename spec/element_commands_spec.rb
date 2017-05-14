require 'spec_helper'

module StaticHTMLDriver
	describe 'Element Commands' do
		before(:all) do
			driver.navigate.to SpecSupport::Navigation.url_for('elements.html')
		end

		describe 'Get Element Attribute' do
			it 'gets the attribute value' do
				expect(driver.find_element(tag_name: 'h1').attribute('id')).to eq('header')
			end

			it 'should return nil for non-existent attributes' do
				expect(driver.find_element(id: 'main').attribute('nonexistent')).to be_nil
			end
		end

		describe 'Get Element Tag Name' do
			it 'gets the tag name' do
				expect(driver.find_element(id: 'header').tag_name).to eq('h1')
			end
		end

		describe 'Get Element Text' do
			it 'gets the text' do
				expect(driver.find_element(id: 'main').text).to eq('Main content')
			end

			it 'gets the trimmed text' do
				expect(driver.find_element(id: 'container').text).to eq('Secondary content')
			end
		end

		describe 'Is Element Enabled' do
			it 'identifies enabled elements' do
				expect(driver.find_element(id: 'isEnabled')).to be_enabled
				expect(driver.find_element(id: 'isDisabled')).not_to be_enabled
			end
		end

		describe 'Find Element' do
			it 'finds elements by css selector' do
				expect(driver.find_element(css: '#main').text).to eq('Main content')
			end

			it 'finds elements by link text' do
				expect(driver.find_element(link_text: 'First menu link').text).to eq('First menu link')
			end

			it 'finds elements by partial link text' do
				expect(driver.find_element(partial_link_text: 'First menu').text).to eq('First menu link')
			end

			it 'finds elements by tag name' do
				expect(driver.find_element(tag_name: 'h1').attribute('id')).to eq('header')
			end

			it 'finds elements by xpath' do
				expect(driver.find_element(xpath: './/*[@id="main"]').text).to eq('Main content')
			end
		end

		describe 'Find Element From Element' do
			it 'finds elements within an element' do
				container = driver.find_element(id: 'container')
				expect(container.find_element(:class, 'content').text).to eq('Secondary content')
			end
		end

		describe 'Find Elements' do
			it 'finds all matching elements' do
				expect(driver.find_elements(tag_name: 'input').count).to eq(2)
			end
		end

		describe 'Find Elements From Element' do
			it 'finds all matching elements within an element' do
				expect(driver.find_element(id: 'menu').find_elements(css: 'a').count).to eq(2)
			end
		end
	end
end