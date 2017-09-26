require 'shellwords'
require_relative '../lib/um.rb'

options = Options.parse! do |available_opts, set_opts|
  available_opts.banner = 'usage: um rm [OPTIONS...] <page name>'

  available_opts.on(
    '-t', '--topic TOPIC', 'Set topic for a single invocation.'
  ) do |topic|
    set_opts[:topic] = topic
  end

  available_opts.on('-h', '--help', 'Print this help message.') do
    puts available_opts
    exit 0
  end
end

page_name = ARGV.first
if page_name.to_s.empty?
  $stderr.puts options.available
  exit 1
end

config = UmConfig.source
topic = options[:topic] || Topic.current(config[:default_topic])
page_path = config.existing_page_path(page_name, topic)

unless page_path
  msg = %{No um page found for "#{page_name}" under topic "#{topic}."}
  $stderr.puts msg
  exit 2
end

puts "Are you sure you want to remove the page for '#{page_name}'? (y/n):"
input = $stdin.gets.chomp

if input == 'y'
  exec(%{rm "#{page_path}"})
end
