require 'fileutils'
require 'shellwords'
require 'tempfile'
require 'optparse'
require_relative "../lib/um.rb"

options = {}
opts_parser = OptionParser.new do |opts|
  opts.banner = "usage: um set [OPTIONS...] <page name>"

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

config = UmConfig.source
topic = options[:topic] || Topic.current(config["default_topic"])

page_dir = "#{config["pages_directory"]}/#{topic}"
page_path = page_dir + "/#{page_name}.txt"

# set up template
temp_file = nil
unless File.exists? page_path
  default_template_path = File.expand_path("../share/template.txt", 
                                           File.dirname(__FILE__))
  template_path = File.expand_path(UmConfig::CONFIG_DIR_REL_PATH) + "/template.txt"

  FileUtils.mkdir_p page_dir

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
  temp_file = Tempfile.new("um")
  temp_file.write processed_template
  temp_file.flush
end

begin
  editor = config["editor"].shellescape
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
