require_relative '../lib/um.rb'

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
topic = options[:topic] || Topic.current(config[:default_topic])

pages_path = "#{config[:pages_directory]}/#{topic}"
unless Dir.exists? pages_path
  $stderr.puts %{No pages found for topic "#{topic}."}
  exit 2
end

if $stdout.isatty
  exec(%{ls "#{pages_path}" | sed 's/.txt//' | column})
else
  exec(%{ls "#{pages_path}" | sed 's/.txt//' })
end
