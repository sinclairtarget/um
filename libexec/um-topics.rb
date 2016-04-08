require 'optparse'
require_relative '../lib/um.rb'

opts_parser = OptionParser.new do |opts|
  opts.banner = "usage: um topics [OPTIONS...]"

  opts.on("-h", "--help", "Print this help message.") do
    puts opts
    exit 0
  end
end

begin
  opts_parser.parse! ARGV
rescue OptionParser::InvalidOption => e
  $stderr.puts e
  $stderr.puts opts_parser
  exit 1
end

config = UmConfig.source
files = Dir["#{config[:pages_directory]}/*"].map { |file| File.basename(file) }

output = files.join("\n")

if $stdout.isatty
  exec(%{echo "#{output}" | column})
else
  puts output
end
