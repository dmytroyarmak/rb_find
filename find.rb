require "./lib/find"
require "./lib/find_option_parser"

options = FindOptionParser.parse(ARGV)
files = Find.new(ARGV[0], options)
puts files.all