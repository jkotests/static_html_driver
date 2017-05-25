require 'spec_helper'

RSpec.describe 'Element' do
	before(:all) do
		browser.goto(SpecSupport::Navigation.url_for('elements.html'))
	end

	describe '#attribute_value' do
		it 'returns the attribute value for present attributes' do
			expect(browser.h1.attribute_value('id')).to eq('header')
		end

		it 'returns nil for non-existent attributes' do
			expect(browser.element(id: 'main').attribute_value('missing')).to be_nil
		end
	end

	describe '#tag_name' do
		it 'returns the tag name' do
			expect(browser.element(id: 'header').tag_name).to eq('h1')
		end
	end

	describe '#text' do
		it 'returns the text' do
			expect(browser.element(id: 'main').text).to eq('Main content')
		end

		it 'trims the leading/trailing whitespace' do
			expect(browser.element(id: 'container').text).to eq('Secondary content')
		end
	end

	describe '#enabled?' do
		it 'identifies enabled elements' do
			expect(browser.element(id: 'isEnabled')).to be_enabled
		end

		it 'identifies disabled elements' do
			expect(browser.element(id: 'isDisabled')).not_to be_enabled
		end
	end

	describe '#element' do
		it 'finds the first matching nested element' do
			container = browser.element(id: 'container')
			expect(container.element(class: 'content').text).to eq('Secondary content')
		end
	end

	describe '#elements' do
		it 'finds all matching nested elements' do
			container = browser.element(id: 'menu')
			expect(container.elements(css: 'a').count).to eq(2)
		end
	end
end