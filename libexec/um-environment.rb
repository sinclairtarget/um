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

set_from_config_file = {}
config_file_path = File.expand_path(UmConfig::CONFIG_FILE_REL_PATH)

config = UmConfig.source(set_from_config_file: set_from_config_file)

unless set_from_config_file.empty?
  puts "Options prefixed by '*' are set in #{config_file_path}."
  puts "=" * 80
end

config.each do |key, value|
  option = "#{key} = #{value}"

  if set_from_config_file.has_key? key
    puts "* " + option
  else
    puts "  " + option
  end
end
