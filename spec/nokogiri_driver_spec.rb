require 'spec_helper'

module Selenium
  module WebDriver
    describe Element do
			def url_for(page)
				path = 'file://' + File.join(File.absolute_path(__FILE__), '..', '..', '..', 'selenium/common/src/web')
				"#{path}/#{page}"
			end

			before(:all) do
				@driver = Selenium::WebDriver.for :static_html
			end

			after(:all) do
				@driver.quit
			end

			let(:driver) { @driver }

      it 'should click' do
        driver.navigate.to url_for('formPage.html')
        driver.find_element(id: 'imageButton').click
      end

      it 'should get attribute value' do
        driver.navigate.to url_for('formPage.html')
        expect(driver.find_element(id: 'withText').attribute('rows')).to eq('5')
      end

      it 'should return nil for non-existent attributes' do
        driver.navigate.to url_for('formPage.html')
        expect(driver.find_element(id: 'withText').attribute('nonexistent')).to be_nil
      end

      it 'should get enabled' do
        driver.navigate.to url_for('formPage.html')
        expect(driver.find_element(id: 'notWorking')).not_to be_enabled
      end

      it 'should get tag name' do
        driver.navigate.to url_for('xhtmlTest.html')
        expect(driver.find_element(class: 'header').tag_name).to eq('h1')
      end

      it 'should get text' do
        driver.navigate.to url_for('xhtmlTest.html')
        expect(driver.find_element(class: 'header').text).to eq('XHTML Might Be The Future')
      end
    end
  end
end