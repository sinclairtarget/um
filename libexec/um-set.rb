require 'fileutils'
require 'shellwords'
require 'tempfile'
require_relative "../lib/um.rb"

usage = "usage: um set <page name>"

page_name = ARGV.first
if page_name.to_s.empty?
  $stderr.puts usage
  exit 1
end

config = Config.source
topic = Topic.current

page_dir = "#{config["pages_directory"]}/#{topic}"
page_path = page_dir + "/#{page_name}.txt"

# set up template
temp_file = nil
unless File.exists? page_path
  default_template_path = File.expand_path("../share/template.txt", 
                                           File.dirname(__FILE__))
  template_path = File.expand_path(Config::CONFIG_DIR_REL_PATH) + "/template.txt"

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

  if temp_file and system(%{diff "#{page_path}" "#{temp_file.path}"})
    `rm -f "#{page_path}"`
    temp_file.unlink
    temp_file.close
  end
ensure
  if temp_file
    temp_file.unlink
    temp_file.close
  end
end
