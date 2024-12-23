require_relative 'parser'

picasso_url = "https://www.google.com/search?q=picasso+paintings"
van_gogh_file = "files/van-gogh-paintings.html"
ernst_file = "files/ernst.html"

# initialize with url or filepath
fantastic_parser = FantasticParser.new(van_gogh_file)

# print JSON to console
puts fantastic_parser.result_to_json()

# Optional extra stuff

# output as hash
# puts parsed_html.result_to_hash()

# Parsing other pages from file
# fantastic_parser.parse(ernst_file)
# puts fantastic_parser.result_to_json()

# Parsing other pages page using webdriver

# fantastic_parser.parse(picasso_url)
# puts fantastic_parser.result_to_json()

# close browser after work is done. Only runs when using webdriver
fantastic_parser.cleanup()