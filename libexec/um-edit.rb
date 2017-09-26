require 'fileutils'
require 'shellwords'
require 'tempfile'
require_relative '../lib/um.rb'

options = Options.parse! do |available_opts, set_opts|
  available_opts.banner = 'usage: um edit [OPTIONS...] <page name>'

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

temp_file = nil
unless page_path
  page_path = config.new_page_path(page_name, topic)

  # set up template
  default_template_path = config.default_template_path
  template_path = config.template_path

  FileUtils.mkdir_p(File.dirname(page_path))

  if File.exists? template_path
    FileUtils.cp template_path, page_path
    used_template_path = template_path
  else
    FileUtils.cp default_template_path, page_path
    used_template_path = default_template_path
  end

  template = File.read page_path
  processed_template = Preprocessor.preprocess template, page_name, topic
  File.write page_path, processed_template

  # create temp copy of preprocessed file so we can diff later
  temp_file = Tempfile.new('um')
  temp_file.write processed_template
  temp_file.flush
end

begin
  editor = config[:editor].shellescape
  system(%{#{editor} "#{page_path}"})

  if temp_file
    `diff "#{page_path}" "#{temp_file.path}"`

    if $?.success? # files are the same
      `rm -f "#{page_path}"`
    end
  end
ensure
  if temp_file
    temp_file.unlink
    temp_file.close
  end
end
