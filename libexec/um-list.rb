require 'optparse'
require_relative '../lib/um.rb'

options = {}
opts_parser = OptionParser.new do |opts|
  opts.banner = 'usage: um list [OPTIONS...]'

  opts.on('-t', '--topic TOPIC', 'Set topic for a single invocation.') do |topic|
    options[:topic] = topic
  end

  opts.on('-h', '--help', 'Print this help message.') do
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
topic = options[:topic] || Topic.current(config[:default_topic])

pages_path = "#{config[:pages_directory]}/#{topic}"
unless Dir.exists? pages_path
  $stderr.puts %{No pages found for topic "#{topic}."}
  exit 2
end

if $stdout.isatty
  exec(%{ls "#{pages_path}" | sed 's/.txt//' | column})
else
  exec(%{ls "#{pages_path}" | sed 's/.txt//' })
end
