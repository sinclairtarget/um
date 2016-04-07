require 'optparse'
require_relative '../lib/um.rb'

options = {}
opts_parser = OptionParser.new do |opts|
  opts.banner = "usage: um environment"

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
non_default_keys = UmConfig.non_default_keys(config)
config_file_path = UmConfig.config_path

unless non_default_keys.empty?
  puts "Options prefixed by '*' are set in #{config_file_path}."
  puts "=" * 80
end

config.each do |key, value|
  option = "#{key} = #{value}"

  if non_default_keys.include?(key)
    puts "* " + option
  else
    puts "  " + option
  end
end
