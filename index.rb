require_relative 'parser'

ernst_url = "https://www.google.com/search?q=max+ernst+paintings"
picasso_url = "https://www.google.com/search?q=picasso+paintings"
van_gogh_file = "files/van-gogh-paintings.html"

# initialize with url or filepath
fantastic_parser = FantasticParser.new(van_gogh_file)

# print JSON to console
puts fantastic_parser.result_to_json()

# Optional extra stuff

# output as hash
# puts parsed_html.result_to_hash()

# Parsing other pages page using webdriver

# fantastic_parser.parse(ernst_url)
# puts fantastic_parser.result_to_hash()

# fantastic_parser.parse(picasso_url)
# puts fantastic_parser.result_to_hash()

# close browser after work is done. Only runs when using webdriver
fantastic_parser.cleanup()