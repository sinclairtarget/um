require 'rake/clean'
require 'kramdown'

SOURCE_DIR = 'doc'.freeze
SOURCE_EXT = '.md'.freeze

OUTPUT_DIR = 'doc/man1'.freeze
OUTPUT_EXT = '.1'.freeze

def source_to_out(pathmapable)
  pathmapable.pathmap("#{OUTPUT_DIR}/%f").ext(OUTPUT_EXT)
end

def out_to_source(pathmapable)
  pathmapable.pathmap("#{SOURCE_DIR}/%f").ext(SOURCE_EXT)
end

SOURCE_FILES = FileList["#{SOURCE_DIR}/*#{SOURCE_EXT}"]
OUTPUT_FILES = source_to_out(SOURCE_FILES)

task :default => [:man]

desc 'Converts Markdown man pages to troff man files.'
task :man => OUTPUT_FILES
CLOBBER.include(OUTPUT_DIR)

rule OUTPUT_EXT => [-> (name) { out_to_source(name) }, OUTPUT_DIR] do |t|
  doc = Kramdown::Document.new(File.read(t.source))
  File.write(t.name, doc.to_man)
end

directory OUTPUT_DIR

desc 'Install gem under GEM_HOME'
task :install do
  sh 'gem build um.gemspec'
  sh 'gem install --ignore-dependencies --no-document um*.gem'
end
CLEAN.include('um*.gem')
