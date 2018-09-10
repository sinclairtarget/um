require_relative '../../um.rb'

options = Options.parse! do |available_opts, set_opts|
  available_opts.banner = 'usage: um list [OPTIONS...]'

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

config = UmConfig.source
topic = options[:topic] || Topic.current(config)

topic_directory = config.topic_directory(topic)
unless Dir.exist? topic_directory
  $stderr.puts %{No pages found for topic "#{topic}."}
  exit 2
end

if $stdout.isatty
  exec(%{ls "#{topic_directory}" | sed 's/\.[[:alnum:]]*$//' | column})
else
  exec(%{ls "#{topic_directory}" | sed 's/\.[[:alnum:]]*$//' })
end
