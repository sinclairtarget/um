require 'optparse'
require_relative '../lib/um.rb'

$libexec_path = File.dirname(__FILE__)

def run_help_only(file_name)
  exec(%{ruby "#{$libexec_path}/#{file_name}" --help})
end

options = {}
opts_parser = OptionParser.new do |opts|
  opts.banner = "usage: um help <sub-command>"

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

sub_command = ARGV.first
if sub_command.to_s.empty?
  $stderr.puts opts_parser
  exit 1
end

sub_command = Commands.alias(sub_command) || sub_command

file_name = Commands.libexec(sub_command)
if file_name
  run_help_only file_name
else
  $stderr.puts "No sub-command with that name."
end
