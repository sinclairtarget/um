require 'md2man/roff/engine'
require 'shellwords'
require 'tempfile'
require_relative '../lib/um.rb'

options = Options.parse! do |available_opts, set_opts|
  available_opts.banner = 'usage: um read [OPTIONS...] <page name>'

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
topic = options[:topic] || Topic.current(config)
page_path = config.existing_page_path(page_name, topic)

unless page_path
  msg = %{No um page found for "#{page_name}" under topic "#{topic}."}
  $stderr.puts msg
  exit 2
end

if File.extname(page_path) == UmConfig::UM_MARKDOWN_EXT
  begin
    temp_file = Tempfile.new('um')
    roff_output = Md2Man::Roff::ENGINE.render(File.read(page_path))
    File.write temp_file.path, roff_output
    system(%{man "#{temp_file.path}"})
  ensure
    temp_file.unlink
  end
else
  pager = config[:pager].shellescape
  exec(%{#{pager} "#{page_path}"})
end
