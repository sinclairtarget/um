require_relative '../lib/um.rb'

Options.parse! do |available_opts|
  available_opts.banner = 'usage: um topic [OPTIONS...] [topic]'

  available_opts.on('-d', '--default', 'Resets the topic to the default.') do
    Topic.clear
    exit 0
  end

  available_opts.on('-h', '--help', 'Print this help message.') do
    puts available_opts
    exit 0
  end
end

config = UmConfig.source
topic = ARGV.first

if topic.to_s.empty?
  puts Topic.current(config)
else
  Topic.set topic
end
