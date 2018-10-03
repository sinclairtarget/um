require_relative '../lib/um.rb'

Options.parse! do |available_opts|
  available_opts.banner = 'usage: um topics [OPTIONS...]'

  available_opts.on('-h', '--help', 'Print this help message.') do
    puts available_opts
    exit 0
  end
end


config = UmConfig.source
files = Dir["#{config.pages_directory}/*"].map { |file| File.basename(file) }

output = files.join("\n")

if $stdout.isatty
  exec(%{echo "#{output}" | column})
else
  puts output
end
