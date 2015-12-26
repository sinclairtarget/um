require 'shellwords'
require_relative '../lib/um.rb'

program_name = File.basename($PROGRAM_NAME)
usage = "usage: #{program_name} <page name>"

page_name = ARGV.first
unless page_name
  $stderr.puts usage
  exit 1
end

config = Config.source
topic = Topic.current

page_path = "#{config["pages_directory"]}/#{topic}/#{page_name}.txt"
unless File.exist? page_path
  msg = %{No um page found for "#{page_name}" under topic "#{topic}."}
  $stderr.puts msg
  exit 2
end

pager = config["pager"].shellescape
exec(%{#{pager} "#{page_path}"})
