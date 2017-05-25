require 'spec_helper'

RSpec.describe 'Browser' do
	describe '#goto' do
		it 'reads a local HTML file' do
			browser.goto(SpecSupport::Navigation.url_for('elements.html'))
			expect(browser.text).to include('Main content')
		end

		it 'reads a string of HTML' do
			html = File.read(SpecSupport::Navigation.url_for('elements.html'))
			browser.goto(html)
			expect(browser.text).to include('Main content')
		end
	end

	describe '#element' do
		before(:all) do
			browser.goto(SpecSupport::Navigation.url_for('elements.html'))
		end

		it 'finds an element by css selector' do
			expect(browser.element(css: '#main').text).to eq('Main content')
		end

		it 'finds an element by link text' do
			expect(browser.element(link_text: 'First menu link').text).to eq('First menu link')
		end

		it 'finds an element by partial link text' do
			expect(browser.element(partial_link_text: 'First menu').text).to eq('First menu link')
		end

		it 'finds an element by tag name' do
			expect(browser.element(tag_name: 'h1').id).to eq('header')
		end

		it 'finds an element by xpath' do
			expect(browser.element(xpath: './/*[@id="main"]').text).to eq('Main content')
		end
	end

	describe '#elements' do
		it 'finds all matching elements' do
			browser.goto(SpecSupport::Navigation.url_for('elements.html'))
			expect(browser.elements(tag_name: 'input').count).to eq(2)
		end
	end
end