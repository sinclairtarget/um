require 'shellwords'
require 'optparse'
require_relative '../lib/um.rb'

options = {}
opts_parser = OptionParser.new do |opts|
  opts.banner = "usage: um read [OPTIONS...] <page name>"

  opts.on("-t", "--topic TOPIC", "Set topic for a single invocation.") do |topic|
    options[:topic] = topic
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

page_name = ARGV.first
if page_name.to_s.empty?
  $stderr.puts opts_parser
  exit 1
end

config = Config.source
topic = options[:topic] || Topic.current(config["default_topic"])

page_path = "#{config["pages_directory"]}/#{topic}/#{page_name}.txt"
unless File.exists? page_path
  msg = %{No um page found for "#{page_name}" under topic "#{topic}."}
  $stderr.puts msg
  exit 2
end

pager = config["pager"].shellescape
exec(%{#{pager} "#{page_path}"})
