program_name = File.basename($PROGRAM_NAME)
usage = "usage: #{program_name} <page name>"

page_name = ARGV.first
if page_name.nil?
  $stdout.puts usage
  exit 1
end

# source config
config = { "pager" => "less", 
           "pages_directory" => "/Users/sinclairtarget/Dropbox (Personal)/um/pages" }
topic = "shell"

page_path = "#{config["pages_directory"]}/#{topic}/#{page_name}.txt"
unless File.exist? page_path
  msg = %{No um page found for "#{page_name}" under topic "#{topic}."}
  $stdout.puts msg
  exit 1
end

exec(%{#{config["pager"]} "#{page_path}"})
