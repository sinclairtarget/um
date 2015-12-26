require_relative '../lib/um.rb'

config = Config.source
topic = Topic.current

pages_path = "#{config["pages_directory"]}/#{topic}"
unless Dir.exists? pages_path
  $stderr.puts %{No pages found for topic "#{topic}."}
  exit 2
end

exec(%{ls "#{pages_path}" | sed 's/.txt//' | column})
