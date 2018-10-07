require_relative '../lib/um.rb'

def run_help_only(file_name)
  exec(%{ruby "#{file_name}" --help})
end

options = Options.parse! do |opts|
  opts.banner = 'usage: um help <sub-command>'

  opts.on('-h', '--help', 'Print this help message.') do
    puts opts
    exit 0
  end
end

sub_command = ARGV.first
if sub_command.to_s.empty?
  $stderr.puts options.available
  exit 1
end

libexec_dir = File.expand_path('..', __FILE__)
file_name = Commands.file_path_for_command(libexec_dir, sub_command)
if file_name
  run_help_only file_name
else
  $stderr.puts 'No sub-command with that name.'
end
