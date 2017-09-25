require 'optparse'

# Thin wrapper for optparse
class Options
  def initialize(parser, set_options)
    @parser = parser
    @set_options = set_options
  end

  def available
    @parser
  end

  def [](key)
    @set_options[key]
  end

  def self.parse!
    set_options = {}

    opts_parser = OptionParser.new do |opts|
      yield opts, set_options
    end

    begin
      opts_parser.parse! ARGV
    rescue OptionParser::InvalidOption => e
      $stderr.puts e
      $stderr.puts opts_parser
      exit 1
    end

    Options.new opts_parser, set_options
  end
end
