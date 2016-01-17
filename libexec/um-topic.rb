require 'optparse'
require_relative '../lib/um.rb'

opts_parser = OptionParser.new do |opts|
  opts.banner = "usage: um topic [OPTIONS...] [topic]"

  opts.on("-d", "--default", "Set the default topic.") do
    Topic.clear
    exit 0
  end

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
topic = ARGV.first

if topic.to_s.empty?
  puts Topic.current(config["default_topic"])
else
  Topic.set topic
end
