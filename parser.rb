require 'nokolexbor'
require 'json'
require "selenium-webdriver"

class FantasticParser
  attr_reader :html

  def initialize(path = nil)
    return if path.nil?

    fetch_html(path)
    parse(path)
  end

  # return nicely formatted JSON
  def result_to_json
    puts JSON.pretty_generate(@result)
  end

  # return ruby hash for further doings
  def result_to_hash
    @result
  end

  # free up resources
  def cleanup
    @driver.quit if @driver
  end

  def parse(path)
    # resolve correct html either by file or url
    fetch_html(path)

    # full data:image urls are stored in script tags
    # we need to extract them for later use
    data_images = []
    html.css('script').each do |script|
      if script.content.include? "s='data:image" then
        strings = script.content.scan(/'([^']+)'/).flatten

        data_images << {
          data_image: strings[0],
          id: strings[1]
        }
      end
    end

    # the MAIN LOOP :D
    parsed_hash = html.css('div.iELo6').map do |el|
      # resolve correct image url
      image_id = el.at_css('img').attr('id')
      image_src = el.at_css('img').attr('data-src') || el.at_css('img').attr('src')
      script_data_image = data_images.find { |data_image| data_image[:id] == image_id }

      image = script_data_image ? script_data_image[:data_image] : image_src

      el_data = {
        name: el.at_css('div.pgNMRc').text,
        link: "https://google.com" + el.at_css('a').attr('href'),
        image: image,
      }

      # only add extensions if there are any
      extensions_el = el.at_css('div.cxzHyb')
      el_data[:extensions] = [extensions_el.text] if extensions_el && extensions_el.text.length > 0

      el_data
    end

    @result = { artworks: parsed_hash }
    { artworks: parsed_hash }
  end

  private

  def fetch_html(path)
    raise ArgumentError, "Please provide a file path or url" if path.nil?

    # Auto-resolve input path type (file or url)
    is_url = path.match?(/^http/)

    if is_url then
      # resorting to selenium since trying open-uri to download page
      # returns html inconsistent with the provided example
      
      # detect if driver is initialized, if not, do so
      if @driver.nil? then
        puts ' loading webdriver... '
        @driver = Selenium::WebDriver.for :firefox, options: Selenium::WebDriver::Firefox::Options.new(args: ['-headless'])
      end
      
      @driver.navigate.to(path)

      # store html from driver
      @html = Nokolexbor::HTML(@driver.page_source)
    else
      @html = Nokolexbor::HTML(File.read(path))
    end
  end
end