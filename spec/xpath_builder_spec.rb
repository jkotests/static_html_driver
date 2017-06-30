require 'spec_helper'

RSpec.describe StaticHTMLDriver::XPathBuilder do
	describe '#normalize' do
		context 'removes leading brackets caused by regexp predicates' do
			it 'when a single predicate' do
				builder = XPathBuilder.new("(.//h1)[contains(@class, 'class')]")
				expect(builder.normalize).to eq(".//h1[contains(@class, 'class')]")
			end

			it 'when multiple predicates' do
				builder = XPathBuilder.new("((.//h1)[contains(@class, 'class')])[contains(@id, 'id_value')]")
				expect(builder.normalize).to eq(".//h1[contains(@class, 'class')][contains(@id, 'id_value')]")
			end

			it 'when attribute has space normalized' do
				builder = XPathBuilder.new("(.//a)[contains(normalize-space(@href), 'example')]")
				expect(builder.normalize).to eq(".//a[contains(normalize-space(@href), 'example')]")
			end
		end
	end
end